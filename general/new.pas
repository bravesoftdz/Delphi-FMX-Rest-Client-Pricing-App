unit new;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit;

type
  Tfmnew = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Layout2: TLayout;
    updatebtn: TButton;
    closebtn: TButton;
    Layout3: TLayout;
    procedure closebtnClick(Sender: TObject);
    procedure updatebtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmnew: Tfmnew;

implementation
uses
datamod,main;

{$R *.fmx}

procedure Tfmnew.closebtnClick(Sender: TObject);
begin
   fmnew.close;
end;

procedure Tfmnew.FormShow(Sender: TObject);
begin
   edit2.Text:= '';
   edit3.Text:= '';
  edit4.Text:='';
  edit5.text:='';
end;

procedure Tfmnew.updatebtnClick(Sender: TObject);
var
newrec:integer;
begin
//clear any data
Edit1.Text:= '';
edit2.Text:='';
edit3.text:='';
edit4.Text:='';
edit5.Text:='';


   dm.fdmemtable1.last;
   if dm.fdmemtable1.RecordCount <> 0 then
   newrec:= strtoint(dm.fdmemtable1.FieldByName('id').Asstring)
   else
   newrec:= 0;
  dm.fdmemtable1.append;
  dm.FDMemTable1.FieldByName('id').Asstring:= (newrec+1).tostring;
  dm.FDMemTable1.FieldByName('sku').Asstring:= edit1.Text;
  dm.FDMemTable1.FieldByName('skusize').Asstring:= edit2.Text;
  dm.FDMemTable1.FieldByName('barcode').Asstring:= edit3.Text;
  dm.FDMemTable1.FieldByName('description').Asstring:= edit4.Text;
  dm.FDMemTable1.FieldByName('price').Asstring:= edit5.text;
  dm.FDMemTable1.Post;
  dm.FDMemTable1.CommitUpdates;

  fmmain.SavetosimulatedDB(DM.FDmemtable1);
  fmmain.LoadfromsimulatedDB;
  fmnew.close;
end;

end.
