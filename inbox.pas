unit inbox;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ShellCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Memo1: TMemo;
    ShellListView1: TShellListView;
    procedure FormShow(Sender: TObject);
    procedure ShellListView1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormShow(Sender: TObject);
begin
  ShellListView1.Root:='/home/nugroho/sms/inbox';
end;

procedure TForm1.ShellListView1Click(Sender: TObject);
var
  fpesan: TextFile; isipesan: string;
begin
  label1.Caption:='/home/nugroho/sms/inbox/'+ShellListView1.ItemFocused.Caption;
   AssignFile(fpesan, label1.Caption);
   try
    reset(fpesan);
    while not eof(fpesan) do
    begin
      readln(fpesan, isipesan);
      //writeln('Isi Pesan: ', s)
      memo1.Text:=isipesan;
      edit1.Text:=isipesan;
    end;
    CloseFile(fpesan);
  except
    memo1.text:='something salah';
    edit1.text:='something salah';
  end
end;

end.

