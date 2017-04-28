program ProSendToPT;

uses
  SvcMgr,
  USendToPT in 'USendToPT.pas' {SendToPT: TService};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TSendToPT, SendToPT);
  Application.Run;
end.
