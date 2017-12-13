unit Unit4;

interface

uses
  Classes, Unit2, Windows;

type
  Tmythread = class(TThread)
  private
    FKernel1, FKernel2, FUser1, FUser2: SYSTEMTIME;
    Fdotcircle: Integer;
    Findicator: boolean;
    FExampleCalc: Tcalculating;
  protected
    procedure Execute; override;
  public
    procedure setting(ExampleCalc: Tcalculating);
    property Indicator: Boolean read Findicator write Findicator;
    function GetTime: Double;


//    procedure UpdatePi;
  end;

implementation



{ Tmythread }

procedure Tmythread.Execute;
var
  X, Y, R: Double;
  i: Integer;
  lpCreationTime, lpExitTime, lpKernelTime, lpUserTime: FILETIME;
begin
  GetThreadTimes(self.Handle, lpCreationTime, lpExitTime,
    lpKernelTime, lpUserTime);
  FileTimeToSystemTime(lpKernelTime, FKernel1);
  FileTimeToSystemTime(lpUserTime, FUser1);
  R := 0.5;
  while not terminated do
  begin
    Fdotcircle := 0;
    for i := 1 to 10000 do
    begin
      X := Random;
      Y := Random;
      if Sqr(X - R) + sqr(Y - R) <= Sqr(R) then
        inc(Fdotcircle);
    end;
    FExampleCalc.addition(4 * Fdotcircle / (i - 1));
  end;
end;

{procedure UpdatePi;
var qw: Double;    zx:Integer;
 FUpdatePi: Tcalculating;
begin
  for zx:=0 to 100 do
    begin
      FUpdatePi:= TCalculating.addition(Fpi);
      qw:=FUpdatePi;
      lbl1.text:=floattostr(QW);
    end;
      Sleep(1000);
end;      }

function Tmythread.GetTime: Double;
var
  lpCreationTime, lpExitTime, lpKernelTime, lpUserTime: FILETIME;
begin
  GetThreadTimes(self.Handle, lpCreationTime, lpExitTime,
    lpKernelTime, lpUserTime);
  FileTimeToSystemTime(lpKernelTime, FKernel2);
  FileTimeToSystemTime(lpUserTime, FUser2);
  Result:= (FKernel2.wMinute - FKernel1.wMinute) * 60000 + (FKernel2.wSecond
    - FKernel1.wSecond) * 1000 + (FKernel2.wMilliseconds - FKernel1.wMilliseconds)
    + (FUser2.wMinute - FUser1.wMinute) * 60000 + (FUser2.wSecond - FUser1.wSecond)
    * 1000 + (FUser2.wMilliseconds - FUser1.wMilliseconds);
  FileTimeToSystemTime(lpKernelTime, FKernel1);
  FileTimeToSystemTime(lpUserTime, FUser1);
end;

procedure Tmythread.setting(ExampleCalc: Tcalculating);
begin
  FExampleCalc := ExampleCalc;
  Findicator := False;
end;

end.

