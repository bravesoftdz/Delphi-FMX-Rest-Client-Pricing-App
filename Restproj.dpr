program Restproj;

uses
  System.StartUpCopy,
  FMX.Forms,
  datamod in 'datamod.pas' {dm: TDataModule},
  new in 'general\new.pas' {fmnew},
  delete in 'general\delete.pas' {fmdelete},
  edit in 'general\edit.pas' {fmedit},
  main in 'main.pas' {fmmain},
  jsonparser in 'general\jsonparser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfmmain, fmmain);
  Application.CreateForm(Tfmdelete, fmdelete);
  Application.CreateForm(Tfmnew, fmnew);
  Application.CreateForm(Tfmedit, fmedit);
  Application.Run;
end.
