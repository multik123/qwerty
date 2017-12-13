unit Unit2;

interface
uses
  SyncObjs, unit3333;
type
  TCalculating = class
  private
    FPi: Double;
    FModified: Boolean;
    Fcritical: TCriticalSection;

    Fcount: int64;
    function GetPi: Double;
  public
    constructor Create;
    destructor destroy;
    procedure addition(newpi: double);
    property Modified: Boolean read FModified;
    property Pi: Double read GetPi;
    property Count: int64 read FCount;

  end;

implementation

{ TCalculating }

procedure TCalculating.addition(newpi: double);
var FPiThread:TPiThread;
begin
  Fcritical.Enter;                      //считает каждый раз новое                                             //число pi
  try
    Fpi:=(FPi*Fcount+newpi)/(fcount+1);
    FModified:=True;
    Inc(FCount);
    FPiThread.SendPi(Fpi);
  finally
    Fcritical.Leave;
  end
end;

constructor TCalculating.Create;
begin
  Fcritical := TCriticalSection.Create;
  Fcount := 0;
  Fmodified := false;
end;

destructor TCalculating.destroy;
begin
  Fcritical.Destroy;
end;

function TCalculating.GetPi: Double;
begin
  result := FPi;
  fmodified := False;
end;

end.

