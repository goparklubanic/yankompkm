unit utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mysql55conn, sqldb, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, DBGrids, DbCtrls, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    dsMessages: TDataSource;
    dsNumbers: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    qrySenders: TSQLQuery;
    qryMessages: TSQLQuery;
    sqtrx: TSQLTransaction;
    StatusBar1: TStatusBar;
    tconn55: TMySQL55Connection;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  sent;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormResize(Sender: TObject);
begin
   form1.Width:=842;
   form1.Height:=543;
   form1.Top:=0;
   form1.Left:=0;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  DBGrid1.Columns.Items[0].Width:=300;
end;

procedure TForm1.DBGrid1CellClick(Column: TColumn);
var sender: string;
begin
  sender:=DBGrid1.DataSource.DataSet.Fields[0].Value;
  Edit1.Text:=sender;
  qryMessages.Active:=False;
  qryMessages.SQL.Text:='SELECT ReceivingDateTime,TextDecoded, ID FROM inbox WHERE SenderNumber='+quotedStr(sender)+' LIMIT 50';
  qryMessages.Active:=True;
  DBGrid2.Columns.Items[0].Width:=130;
  DBGrid2.Columns.Items[1].Width:=330;
  DBGrid2.Columns.Items[2].Width:=50;
  Memo1.Text:='';
end;

procedure TForm1.Button1Click(Sender: TObject);
var sql,destnum,msgtext: string;
begin
  destnum:=quotedStr(Edit1.Text);
  msgtext:=quotedStr(Memo2.Text);
  sql:='INSERT INTO outbox (DestinationNumber,TextDecoded,CreatorID) VALUES ('+destnum+','+msgtext+','+quotedStr('PUSKESMAS')+')';
  qrySenders.Active:=False;
  qryMessages.Active:=False;
  sqtrx.Commit;
  sqtrx.StartTransaction;
  tconn55.ExecuteDirect(sql);
  sqtrx.Commit;
  qrySenders.Active:=True;
  qryMessages.Active:=True;
  Memo2.Text:='';

end;

procedure TForm1.Button2Click(Sender: TObject);
var msgid,sql: string;
begin
  msgid:=quotedStr(label5.Caption);
  qrySenders.Active:=False;
  qryMessages.Active:=False;

  sql:='DELETE FROM inbox WHERE ID='+msgid;
  sqtrx.Commit;
  sqtrx.StartTransaction;
  tconn55.ExecuteDirect(sql);
  sqtrx.Commit;

  qrySenders.Active:=True;
  qryMessages.Active:=True;

end;

procedure TForm1.Button3Click(Sender: TObject);
var sendnum,sql: string;
begin
  sendnum:=quotedStr(Edit1.Text);
  qrySenders.Active:=False;
  qryMessages.Active:=False;

  sql:='DELETE FROM inbox WHERE SenderNumber='+sendnum;
  sqtrx.Commit;
  sqtrx.StartTransaction;
  tconn55.ExecuteDirect(sql);
  sqtrx.Commit;

  qrySenders.Active:=True;
  qryMessages.Active:=True;


end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  form1.Hide;
  form2.Show;
end;

procedure TForm1.DBGrid2CellClick(Column: TColumn);
begin
  Memo1.Text:=DBGrid2.DataSource.DataSet.Fields[1].Value;
  Label5.Caption:=DBGrid2.DataSource.DataSet.Fields[2].Value;
end;

procedure TForm1.Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  qrySenders.Active:=False;
  qrySenders.SQL.Text:='SELECT SenderNumber FROM inbox WHERE SenderNumber LIKE '+quotedStr('%'+edit2.Text+'%')+' LIMIT 20';
  qrySenders.Active:=True;
  if Edit2.Text='' then
  begin
    qrySenders.Active:=False;
    qrySenders.SQL.Text:='SELECT DISTINCT(SenderNumber) FROM inbox LIMIT 200';
    qrySenders.Active:=True;
  end;

end;

end.

