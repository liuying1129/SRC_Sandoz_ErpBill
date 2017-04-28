program ProReadFromPT;

uses
  SvcMgr,
  UReadFromPT in 'UReadFromPT.pas' {ReadFromPT: TService};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TReadFromPT, ReadFromPT);
  Application.Run;
end.
