unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
const l_wierz=6;          //liczba wierzcholkow
      l_kol=4;            //liczba kolorow
      l_kraw=9;           //liczba krawedzi
var bitmapa1,bitmapa2:TBitmap;
    plik:TextFile;
    x,y,i,licz:integer;
    S:string;
    wierz:array [0..l_wierz-1] of byte;
    kraw :array [0..l_kraw-1,0..1] of byte;
    kolory:array [0..6] of byte;
    prawy:boolean;
begin
     licz:=0;
     prawy:=true;
     AssignFile(plik,'d.txt');
     Rewrite(plik);
     for i:=1 to l_wierz-1 do
     begin
       wierz[i]:=0
     end;

     kraw[0][0] := 1; kraw[0][1] := 4;  //krawedzie
     kraw[1][0] := 1; kraw[1][1] := 5;
     kraw[2][0] := 2; kraw[2][1] := 3;
     kraw[3][0] := 2; kraw[3][1] := 4;
     kraw[4][0] := 2; kraw[4][1] := 6;
     kraw[5][0] := 3; kraw[5][1] := 4;
     kraw[6][0] := 3; kraw[6][1] := 6;
     kraw[7][0] := 4; kraw[7][1] := 5;
     kraw[8][0] := 4; kraw[8][1] := 6;
     while true do
     begin
       for i:=0 to l_kraw-1 do
       begin
         if wierz[kraw[i][0]-1]=wierz[kraw[i][1]-1] then
         begin
           prawy:=false;
           break;
         end;
       end;
       if prawy then
       begin
         licz:=licz+1;
         for i:=0 to l_wierz-1 do
         begin
           write(plik,wierz[i]);
         end;
         writeln(plik,'');
       end;
       wierz[0]:=wierz[0]+1;
       for i:=0 to l_wierz-2 do
       begin
         if wierz[i]=l_kol then
         begin
           wierz[i]:=0;
           wierz[i+1]:=wierz[i+1]+1;
         end;
       end;
       if wierz[l_wierz-1]=l_kol then
       begin
         break;
       end;
       prawy:=true;
     end;
     closeFile(plik);


     Reset(plik);
     licz:=0;
     While not Eof(plik) do
     begin
       Readln(plik,S);
       for i:=1 to 6 do
       begin
         kolory[i]:=Ord(S[i])-48;
       end;
       bitmapa1:=TBitmap.Create;
       bitmapa2:=TBitmap.Create;
       bitmapa1.LoadFromFile('pierwowzor.bmp'); //grafika z grafem
       bitmapa2.Assign(bitmapa1);
       for i:=1 to 6 do
       begin
         case kolory[i] of
         0:bitmapa2.Canvas.Brush.Color:=clWhite;  //kolory
         1:bitmapa2.Canvas.Brush.Color:=clRed;
         2:bitmapa2.Canvas.Brush.Color:=clBlue;
         3:bitmapa2.Canvas.Brush.Color:=clGreen;
         end;
         case i of
         1:begin
           x:=17;                              //wspolrzedne lewego gornego piksela poszczegolnyhc wierzcholkow
           y:=20;
           end;
         2:begin
           x:=196;
           y:=20;
           end;
         3:begin
           x:=106;
           y:=20;
           end;
         4:begin
           x:=105;
           y:=111;
           end;
         5:begin
           x:=18;
           y:=111;
           end;
         6:begin
           x:=198;
           y:=111;
           end;
         end;
         bitmapa2.canvas.Rectangle(x,y,x+14,y+14);    //14 tu to wymiar wierzcholkow
       end;
       licz:=licz+1;
       bitmapa2.Savetofile('Graf'+inttostr(licz)+'.bmp');


end;
Label1.Visible:=True;
end;
end.

