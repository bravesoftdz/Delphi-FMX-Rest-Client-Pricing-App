unit input;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit,System.Json;

type
  Tfminput = class(TForm)
    procedure FormShow(Sender: TObject);
    procedure btnputClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }
  end;

var
  fminput: Tfminput;
   sku,skusize,description,barcode,price:string;

implementation

{$R *.fmx}

uses main, datamod, jsonparser;

procedure Tfminput.btnputClick(Sender: TObject);
var
index:string;
restsend:string;
JValue:TJSONValue;
begin
 {fmmain.Memo1.ClearContent;
 index:=inttostr(fmmain.IndexRow);
 restsend:=  ParsetoJson(index,sku,skusize,description,barcode,price);
 //dm.RESTRequest1.method:=rmput; //put
 dm.restrequest1.Resource:= 'pricing/update/'+restsend;
 dm.RESTRequest1.Execute;

 jValue:=dm.RESTResponse1.JSONValue;
 fmmain.Memo1.Text:= jValue.ToString;
 fminput.Close;}
end;

procedure Tfminput.ButtonDeleteClick(Sender: TObject);
var
index:string;
restsend:string;
JValue:TJSONValue;
begin
 {fmmain.Memo1.ClearContent;
 index:=inttostr(fmmain.IndexRow);
 restsend:=  ParsetoJson(index,sku,skusize,description,barcode,price);
 //dm.RESTRequest1.Method:= 3; //delete
 dm.restrequest1.Resource:= 'pricing/delete/'+restsend;
 dm.RESTRequest1.Execute;

 jValue:=dm.RESTResponse1.JSONValue;
 fmmain.Memo1.Text:= jValue.ToString;
 fminput.Close; }
end;

procedure Tfminput.FormShow(Sender: TObject);
begin
 //  dm.FDMemTable1.FieldByName('id').AsInteger:= fmmain.IndexRow;
   sku:= dm.FDMemTable1.FieldByName('sku').Asstring;
  skusize:=dm.FDMemTable1.FieldByName('skusize').Asstring;
  barcode:=dm.FDMemTable1.FieldByName('barcode').Asstring;
  description:=dm.FDMemTable1.FieldByName('description').Asstring;
  price:=dm.FDMemTable1.FieldByName('price').Asstring;
  //edit2.Text:= fmmain.Indexrow.ToString;
  //edit3.Text:= fmmain.Indexrow.ToString;
end;

end.
