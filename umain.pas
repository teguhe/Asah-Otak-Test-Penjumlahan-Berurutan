unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Grids;

type

  { TForm1 }

  TForm1 = class(TForm)
    btGo: TButton;
    cbJumlahData: TComboBox;
    cbMode: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbHasil: TLabel;
    lbIterasi: TLabel;
    lbAngka: TLabel;
    pg1: TPageControl;
    sgRiwayat: TStringGrid;
    tAngkaAcak: TTabSheet;
    tRiwayat: TTabSheet;
    tHasil: TTabSheet;
    tm1: TTimer;
    procedure kosongkanGrid;
    procedure btGoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tm1Timer(Sender: TObject);
  private
    jumlah_data, iterasi : integer;
    hasil : integer;

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

  Position:=poScreenCenter;
  Caption :='Test Penjumlahan Berurutan - By Teguh Prasetyo';

end;

procedure TForm1.kosongkanGrid;
begin
  with sgRiwayat do
    begin

      ColCount:=3;
      RowCount:=jumlah_data+1;

      FixedCols:=1;
      FixedRows:=0;

      ColWidths[0]:=30;
      ColWidths[1]:=70;
      ColWidths[2]:=70;

      Cells[0,0]:='No. ';
      Cells[1,0]:='Angka Soal';
      Cells[2,0]:='Hasil';

    end;
end;

procedure TForm1.tm1Timer(Sender: TObject);
var angkatemporary : Integer;
begin

  randomize;

  if iterasi<jumlah_data then
  begin
    if cbMode.ItemIndex=0    then angkatemporary:=Random(9);
    if cbMode.ItemIndex=1    then angkatemporary:=Random(99);
    if cbMode.ItemIndex=2    then angkatemporary:=Random(999);
    if cbMode.ItemIndex=3    then angkatemporary:=Random(9999);
    if cbMode.ItemIndex=4    then angkatemporary:=Random(99999);

    lbAngka.Caption:='_';
    //lbAngka.Caption:=IntToStr(angkatemporary);
    iterasi:=iterasi+1;
    lbIterasi.Caption:='Iterasi ke : '+IntToStr(iterasi);
    hasil:=hasil+angkatemporary;

    if iterasi mod 2 = 0 then lbAngka.Caption:='_'+IntToStr(angkatemporary)+'_';
    if iterasi mod 2 = 1 then lbAngka.Caption:='__'+IntToStr(angkatemporary)+'__';

    //ada data to cell
    sgRiwayat.Cells[0, iterasi]:=IntToStr(iterasi);
    sgRiwayat.Cells[1, iterasi]:=IntToStr(angkatemporary);
    sgRiwayat.Cells[2, iterasi]:=IntToStr(hasil);

  end
  else
  begin
    tm1.Enabled:=false;
    lbHasil.Caption:=IntToStr(hasil);

  end;

end;

procedure TForm1.btGoClick(Sender: TObject);
begin

  //set variabel ke 0
  hasil:=0;
  iterasi := 0;
  jumlah_data:=StrToInt(cbJumlahData.Text);
  lbAngka.Caption:='___';

  //kosongkan grid
  kosongkanGrid;
  pg1.ActivePage:=tAngkaAcak;
  //sgRiwayat.RowCount:=jumlah_data;

  //set angka random
  tm1.Enabled:=true;

end;

end.

