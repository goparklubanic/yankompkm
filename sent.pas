unit sent;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, DBGrids;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    dsSentItem: TDataSource;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    qrySentitem: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
  utama;

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormResize(Sender: TObject);
begin
  form2.Width:=842;
  form2.Height:=543;
  form2.Top:=0;
  form2.Left:=0;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  form2.Hide;
  form1.Show;
end;

procedure TForm2.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  qrySentitem.Active:=False;
  qrySentitem.SQL.Text:='SELECT DeliveryDateTime,DestinationNumber,TextDecoded from sentitems WHERE DestinationNumber LIKE '+quotedStr('%'+Edit1.Text+'%')+' LIMIT 50';
  qrySentitem.Active:=True;
  if Edit1.Text='' then
  begin
    qrySentitem.Active:=False;
    qrySentitem.SQL.Text:='SELECT DeliveryDateTime,DestinationNumber,TextDecoded from sentitems LIMIT 50';
    qrySentitem.Active:=True;
  end;
end;

end.

