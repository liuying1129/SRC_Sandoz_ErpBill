program ErpBill;

uses
  Forms,
  UfrmMain in 'UfrmMain.pas' {frmMain},
  UfrmCommCode in 'UfrmCommCode.pas' {frmCommCode},
  UDM in 'UDM.pas' {DM: TDataModule},
  UfrmInputASN in 'UfrmInputASN.pas' {frmInputASN},
  UfrmInputPKT in 'UfrmInputPKT.pas' {frmInputPKT},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  Ufrmdocset in 'Ufrmdocset.pas' {frmdocset};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
