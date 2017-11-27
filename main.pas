{
Calling Rest
 Get All 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/'
Get One 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/id'
Put One 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/update/id'
Post 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/add'
Delete 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/delete/id'
 }

unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid,
  System.Bindings.Outputs, Fmx.Bind.Editors, FMX.StdCtrls, Data.Bind.Components,
  Data.Bind.Grid, Data.Bind.DBScope, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.Edit, FMX.Memo,System.JSON, Data.Bind.Controls, FMX.Layouts,
  Fmx.Bind.Navigator, FMX.Objects, FMX.TabControl,REST.Types,Data.DB,
  FireDAC.Stan.Intf,FireDAC.Comp.Client;

type
  Tfmmain = class(TForm)
    Memo1: TMemo;
    ToolBar1: TToolBar;
    Layout1: TLayout;
    ToolBar2: TToolBar;
    Label1: TLabel;
    Layout2: TLayout;
    btngetall: TButton;
    Button7: TButton;
    BindNavigator1: TBindNavigator;
    Text1: TText;
    deletebtn: TButton;
    Posttowebbtn: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ToolBar3: TToolBar;
    getwebbtn: TButton;
    Edit2: TEdit;
    Button2: TButton;
    BindNavigator2: TBindNavigator;
    Text2: TText;
    Grid2: TGrid;
    Memo2: TMemo;
    Savewebbtn: TButton;
    SavetoDBbtn: TButton;
    Getdbbtn: TButton;
    editbtn: TButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Grid1: TGrid;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    BindSourceDB2: TBindSourceDB;
    LinkGridToDataSourceBindSourceDB2: TLinkGridToDataSource;
    procedure btngetallClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure getwebbtnClick(Sender: TObject);
    procedure btngetoneClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure PosttowebbtnClick(Sender: TObject);
    procedure deletebtnClick(Sender: TObject);
    procedure SavewebbtnClick(Sender: TObject);
    procedure SavetoDBbtnClick(Sender: TObject);
    procedure GetdbbtnClick(Sender: TObject);
    procedure editbtnClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
  private
   function setJsondatafromtable(memtable: TFDmemtable):string;
       { Private declarations }
  public
   procedure LoadfromsimulatedDB;
   function getDBpath:string;
   procedure SavetosimulatedDB(memtable:Tfdmemtable);

    { Public declarations }
  end;

var
  fmmain: Tfmmain;

implementation

{$R *.fmx}

uses datamod,new,edit,delete,jsonparser;

procedure Tfmmain.getwebbtnClick(Sender: TObject);
var
 JValue:TJSONValue;
begin
 Memo2.clearcontent;
 dm.RESTResponseDataSetAdapter1.Dataset:= DM.FDMemTable2;
 dm.RESTResponseDataSetAdapter1.Active:= true;
 dm.RESTClient1.BaseURL:= 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing';
 dm.RESTRequest1.method:= TRESTRequestMethod.rmGET;
 try
 dm.RESTRequest1.Execute;
 // dm.FDMemTable2.Active:=true;
 //dm.RESTResponseDataSetAdapter2.Active:=true;
 //dm.RESTResponseDataSetAdapter1.Active:=false;

 if dm.restresponse1.StatusCode <> 200 then
 begin
 memo1.Text:= dm.restresponse1.Errormessage;
 exit
 end;
   jValue:=dm.RESTResponse1.JSONValue;
 Memo2.Text:= jValue.ToString;
 except
  on exception:ERESTException do
  Showmessage('Could not connect to Webserver');
  on exception:ERequestError do
   Showmessage('Could not connect to the Internet');
      end;
  //release
 //dm.RESTResponseDataSetAdapter1.Active:= False;
//  dm.RESTResponseDataSetAdapter1.Dataset:= null;
 end;

procedure Tfmmain.btngetallClick(Sender: TObject);
var
  JValue:TJSONValue;
begin
 dm.RESTClient2.Bindsource.Active:=false;
 Memo1.Lines.Clear;
 dm.RESTClient2.Bindsource.Active:=true;

 dm.RESTResponseDataSetAdapter1.dataset:= dm.FDMemTable1;
 dm.RESTResponseDataSetAdapter1.Active:=true;
 dm.RESTClient1.BaseURL:= 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing';
 dm.RESTRequest1.method:= TRESTRequestMethod.rmGET;
 dm.RESTRequest1.Execute;
 //get response message status
 if dm.restresponse1.StatusCode <> 200 then
begin
 memo1.lines.Add(dm.restresponse1.Errormessage);
  end
 else
 begin
 jValue:=dm.RESTResponse1.JSONValue;
 Memo1.lines.Add(jValue.ToString);
 end;
 dm.RESTResponseDataSetAdapter1.dataset:= dm.FDMemTable2;
 dm.RESTResponseDataSetAdapter1.Active:=true;
  end;

procedure Tfmmain.btngetoneClick(Sender: TObject);
var
JValue:TJSONValue;
begin
  Memo2.clearcontent;
 dm.RESTResponseDataSetAdapter1.Dataset:= DM.FDMemTable2;
 dm.RESTResponseDataSetAdapter1.Active:= true;
 dm.RESTClient1.BaseURL:= 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/'+edit2.text;
 dm.RESTRequest1.method:= TRESTRequestMethod.rmGET;
 dm.RESTRequest1.Execute;
 //get response
 jValue:=dm.RESTResponse1.JSONValue;
 Memo2.Text:= jValue.ToString;
 end;

procedure Tfmmain.SavewebbtnClick(Sender: TObject);
begin
   savetosimulatedDB(dm.fdmemtable2);
end;


procedure Tfmmain.TabControl1Change(Sender: TObject);
begin
if tabcontrol1.ActiveTab = tabitem1 then
begin
  loadfromsimulatedDB;
 end;
end;

procedure Tfmmain.SavetoDBbtnClick(Sender: TObject);
begin
   SavetosimulatedDB(DM.FDmemtable2);
   memo1.lines.clear;
end;

procedure Tfmmain.PosttowebbtnClick(Sender: TObject);
var
  JValue:TJSONValue;
  JText:string;
  jparse:string;
begin
  Memo1.Lines.Clear;
   //delete all items on the web
 dm.RestRequest2.Body.ClearBody;
 dm.RESTClient2.BaseURL:= 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/delete/0';
 dm.RESTRequest2.method:= TRESTRequestMethod.rmDelete;
 dm.RESTRequest2.Execute;

 memo1.lines.add('Deleting all Data on Webserver.....');
 memo1.lines.add(dm.RESTResponse2.Content + '   Status Code : ' +inttostr(dm.RESTResponse2.StatusCode) + ' '+ dm.RESTResponse2.StatusText  );

 memo1.lines.add('');
 memo1.lines.add('Adding Data to Webserver.....');

  dm.RestRequest2.Body.ClearBody;
  dm.RESTRequest2.Body.Add(setJsondatafromtable(dm.fdmemtable1),Trestcontenttype.ctAPPLICATION_JSON);
  dm.RESTClient2.BaseURL:= 'https://www.bayeseanblog.com/blog/public/demo/salesrest/public/api/pricing/add/all';
  dm.RESTRequest2.method:= TRESTRequestMethod.rmPost;
  dm.RESTRequest2.Execute;

  Memo1.lines.Add(dm.RESTResponse2.content+ '   Status Code : ' +inttostr(dm.RESTResponse2.StatusCode) + ' '+ dm.RESTResponse2.StatusText );
  memo1.lines.Add(setJsondatafromtable(dm.fdmemtable1));
  dm.FDMemTable1.First;
   end;


procedure Tfmmain.GetdbbtnClick(Sender: TObject);
begin
  LoadfromsimulatedDB;
  memo1.lines.Clear;
end;

procedure Tfmmain.deletebtnClick(Sender: TObject);
begin
 fmdelete.show;
end;

procedure Tfmmain.editbtnClick(Sender: TObject);
begin
 fmedit.show;
end;

procedure Tfmmain.Button7Click(Sender: TObject);
begin
fmnew.show;
end;

procedure Tfmmain.FormShow(Sender: TObject);
begin
 with dm do
  begin
  FDMemTable1.FieldDefs.Add('id',ftWideString,20,False);
  FDMemTable1.FieldDefs.Add('sku',ftWidestring,20,False);
  FDMemTable1.FieldDefs.Add('skusize',ftWidestring,20,False);
  FDMemTable1.FieldDefs.Add('barcode',ftWidestring, 20,false);
  FDMemTable1.FieldDefs.Add('description',ftWidestring,100,False);
  FDMemTable1.FieldDefs.Add('price',ftWidestring,30,false);
  FDmemtable1.CreateDataset;

  FDMemTable2.FieldDefs.Add('id',ftWideString,20,False);
  FDMemTable2.FieldDefs.Add('sku',ftWidestring,20,False);
  FDMemTable2.FieldDefs.Add('skusize',ftWidestring,20,False);
  FDMemTable2.FieldDefs.Add('barcode',ftWidestring, 20,false);
  FDMemTable2.FieldDefs.Add('description',ftWidestring,100,False);
  FDMemTable2.FieldDefs.Add('price',ftWidestring,30,false);
  FDmemtable2.CreateDataset;
end;

Edit2.Text:= '1';
//set the tab to loaded file
loadfromsimulatedDB;
tabcontrol1.ActiveTab:= tabitem2;

//populate from the Web
getwebbtnclick(self);
end;

function Tfmmain.getDBpath:string;
begin
  result:= ExtractFilepath(Paramstr(0));
 end;

procedure Tfmmain.LoadfromsimulatedDB;
 begin
 dm.FDmemtable1.LoadFromFile(getdbpath+'DB.json',sfJSON);
 end;

procedure Tfmmain.SavetosimulatedDB(memtable:TFDmemtable);
begin
memtable.savetofile(GetDBpath+'DB.json',sfJSON);
end;

function Tfmmain.setJsondatafromtable(memtable: TFDmemtable):string;
var
openbracket:string;
endbracket:string;
begin
memtable.DisableControls;
memtable.active:= true;
memtable.first;
openbracket:= '[';
endbracket:= ']';
while not memtable.Eof do
begin
if memtable.RecNo = 1 then
begin

result:= openbracket+
ParsetoJson(
  dm.FDMemTable1.FieldByName('sku').Asstring,
  dm.FDMemTable1.FieldByName('skusize').Asstring,
   dm.FDMemTable1.FieldByName('description').Asstring,
  dm.FDMemTable1.FieldByName('barcode').Asstring,
  dm.FDMemTable1.FieldByName('price').Asstring)+',';
end;
if(( memtable.RecNo >1 )and (memtable.RecNo < memtable.RecordCount) )then
begin
Result:= result + ParsetoJson(
  dm.FDMemTable1.FieldByName('sku').Asstring,
  dm.FDMemTable1.FieldByName('skusize').Asstring,
   dm.FDMemTable1.FieldByName('description').Asstring,
  dm.FDMemTable1.FieldByName('barcode').Asstring,
  dm.FDMemTable1.FieldByName('price').Asstring) +',';
end;

 if(memtable.RecNo = memtable.RecordCount) then
begin
result:= result+ ParsetoJson(
  dm.FDMemTable1.FieldByName('sku').Asstring,
  dm.FDMemTable1.FieldByName('skusize').Asstring,
   dm.FDMemTable1.FieldByName('description').Asstring,
  dm.FDMemTable1.FieldByName('barcode').Asstring,
  dm.FDMemTable1.FieldByName('price').Asstring) +endbracket;
end;

 memtable.next;
end;
memtable.First;
memtable.EnableControls
end;


end.
