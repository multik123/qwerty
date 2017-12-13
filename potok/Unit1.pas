unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  Unit3333,Unit2, Unit4, Contnrs, Buttons, ExtCtrls, TeeProcs, TeEngine,
  Chart, StdCtrls, Series, XPMan;

type
  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Chart1: TChart;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Timer1: TTimer;
    Series1: TBarSeries;
    Timer2: TTimer;
    XPManifest1: TXPManifest;
    lbledt1: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);


    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);


    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);



  private
    FExampleContr: TObjectList;
    FexamplePi: TCalculating;
 //   FexePi: TPiThread;
    FExampleThread: Tmythread;
      Pithread:TPiThread;
    procedure Reboot;
  public
    { Public declarations }

  end;

 
var
  Form1: TForm1;


implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.Reboot;
var
  i: Integer;
begin
  for i := 0 to FExampleContr.count - 1 do
    (FExampleContr.Items[i] as Tmythread).Indicator := True;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  FexamplePi := tcalculating.create;
  FExampleContr := TObjectList.create;
  Pithread := TPiThread.Create(true);
 // Pithread.SendHandle(Handle);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  number: Integer;
  FExTh: Tmythread;
  FPiThread: TPiThread;
begin
  FExTh := Tmythread.Create(True);
  FExTh.setting(FexamplePi);
  FExTh.FreeOnTerminate := True;
  FExTh.Priority := tpnormal;
  FExTh.Resume;

  FPiThread := TPiThread.Create(True);
  FPiThread.FreeOnTerminate := True;
  FPiThread.Priority := tpnormal;
 // FExTh.setting(Pithread)

  number := FExampleContr.Add(FExTh);
  ComboBox1.AddItem(IntToStr(number), ComboBox1);
  Reboot;
  timer1.Enabled := True;
  timer2.Enabled := True;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
var
  numthread: integer;
begin
  numthread := StrToInt(ComboBox1.text);
  FExampleThread := (FExampleContr.items[numthread] as Tmythread);
  case FExampleThread.Priority of
    tpLower: speedbutton3.down := True;
    tpNormal: speedbutton4.down := True;
    tpHigher: speedbutton5.down := True;
  end;
end;


procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  FExampleThread.Priority := tpIdle;
  Reboot;
end;
procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  FExampleThread.Priority := tpNormal;
  Reboot;
end;
procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  FExampleThread.Priority := tpTimeCritical;
  Reboot;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  i, j: Integer;
begin
  if ComboBox1.text <> '' then
  begin
    ComboBox1.Clear;
    j := FExampleContr.Count - 2;
    for i := 0 to j do
      ComboBox1.AddItem(IntToStr(i), ComboBox1);
    FExampleContr.Extract(FExampleThread);
    FExampleThread.Terminate;
    if FExampleContr.count = 0 then
    begin
      Timer1.Enabled := False;
      timer2.Enabled := False;
    end;
  end;
end;


procedure TForm1.Timer1Timer(Sender: TObject);
begin
 // if (FexamplePi.modified = True or Pithread.Modified = False)
   if      Pithread.Modified = False
   then
  begin
    LabeledEdit1.Text := FloatToStr(FexamplePi.Pi);
    LabeledEdit2.Text := IntToStr(Pithread.count);
    lbledt1.Text:= FloatToStr(Pithread.Pi) ;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  i: Integer;
  countoper: array of double;
  sumoper: double;
  percent: Double;
begin
  setlength(countoper, fexamplecontr.count);
  sumoper := 0;
  for i := 0 to fexamplecontr.count - 1 do
  begin
    countoper[i] := (fexamplecontr.items[i] as Tmythread).gettime;
    sumoper := sumoper + countoper[i];
  end;
  series1.clear;
  for i := 0 to High(countoper) do
  begin
    percent := Round(countoper[i] * 1000 / sumoper) / 10;
    Series1.Add(percent, IntToStr(i) + ': ' + FloatToStr(percent) + '%');
  end;
end;



end.

