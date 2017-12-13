unit Unit3333;

interface

uses
 Classes,  Windows, SyncObjs;

type
  TPiThread = class(TThread)
  private

    Fcount: int64;
    FModified: Boolean;
  //  Form1handle:THandle;
    function GetPi: Double;

  protected
    procedure Execute; override;
  public
    Fcritical: TCriticalSection;
    property Pi: Double read GetPi;
  //  procedure SendHandle(H:THandle);
    procedure SendPi(newpi: double);
    property Modified: Boolean read FModified;
        property Count: int64 read FCount;

  end;

implementation

{type
  TThreadNameInfo = record
    FType: LongWord;     // must be 0x1000
    FName: PChar;        // pointer to name (in user address space)
    FThreadID: LongWord; // thread ID (-1 indicates caller thread)
    FFlags: LongWord;    // reserved for future use, must be zero
  end;
{$ENDIF}

{ TPiThread }

     var  QPi: Double;   Mpi: Double;



procedure TPiThread.Execute;
begin
  Fmodified := false;
  Fcritical := TCriticalSection.Create;
   while not terminated do
      begin
      Sleep(10);
    Fcritical.Enter;                      //считает каждый раз новое                                             //число pi
  try
    Qpi:=(QPi*Fcount+Mpi)/(fcount+1);
    FModified:=True;
    Inc(FCount);                                    //synhronize
  finally
    Fcritical.Leave;


  end
      end;

end;



procedure TPiThread.SendPi(newpi: double);
begin
   MPi := newpi;
end;

{
procedure TPiThread.SendHandle(H: THandle);
begin
   Form1handle := H;
end; }

function TPiThread.GetPi: Double;
begin
  result := QPi;
  fmodified := False;
end;


end.
 