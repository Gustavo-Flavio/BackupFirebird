unit Uprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Imaging.pngimage, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper,
  FireDAC.Phys.IBBase, Data.DB, FireDAC.Comp.Client,ShellApi, Vcl.Samples.Spin,
  Vcl.Buttons, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdCmdTCPClient, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet;


type
 TFrmPrincipal = class(TForm)
    MmBackup: TMemo;
    PageControl1: TPageControl;
    Backup: TTabSheet;
    Restore: TTabSheet;
    Avançado: TTabSheet;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    FDIBBackup1: TFDIBBackup;
    FbRestore: TFDIBRestore;
    Edt_User: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edt_Senha: TEdit;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    EdtCaminhoDados: TEdit;
    Label5: TLabel;
    Btn_Backup: TButton;
    Label6: TLabel;
    Edt_CaminhoGBK: TEdit;
    BtnRestore: TButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    EdtHost: TLabeledEdit;
    EdtPorta: TSpinEdit;
    Porta: TLabel;
    Btn_ProcurarGDB: TButton;
    Btn_ProcurarGbK: TButton;
    Edt_GDBok: TEdit;
    BtnSalvarGDBok: TButton;
    SpeedButton1: TSpeedButton;
    StatusBar1: TStatusBar;
    Timer1: TTimer;
    Online: TTabSheet;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    FDFBOnline: TFDFBOnlineValidate;
    FDIBConfig1: TFDIBConfig;
    TabSheet2: TTabSheet;
    Edtonline: TEdit;
    BtnProcurarGDBOk: TButton;
    Button5: TButton;
    procedure FbRestoreProgress(ASender: TFDPhysDriverService;
      const AMessage: string);
    procedure FDIBBackup1Progress(ASender: TFDPhysDriverService;
      const AMessage: string);
    procedure FDIBBackup1AfterExecute(Sender: TObject);
    procedure fBRestoreBeforeExecute(Sender: TObject);
    procedure FDIBBackup1Error(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure Btn_BackupClick(Sender: TObject);
    procedure BtnRestoreClick(Sender: TObject);
    procedure Btn_ProcurarGDBClick(Sender: TObject);
    procedure Btn_ProcurarGbKClick(Sender: TObject);
    procedure BtnSalvarGDBokClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FDIBValidate1AfterExecute(Sender: TObject);
    procedure FbRestoreAfterExecute(Sender: TObject);
    procedure FbRestoreError(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure FDIBBackup1BeforeExecute(Sender: TObject);
    procedure FDFBOnlineValidateAfterExecute(Sender: TObject);
    procedure FDFBOnlineValidateBeforeExecute(Sender: TObject);
    procedure FDFBOnlineAfterExecute(Sender: TObject);
    procedure FDFBOnlineBeforeExecute(Sender: TObject);
    procedure FDFBOnlineError(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure FDFBOnlineProgress(ASender: TFDPhysDriverService;
      const AMessage: string);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure BtnProcurarGDBOkClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation


{$R *.dfm}

uses uAjuda;

{TFrmPrincipal}
      {Aqui gerar o GDBOK}
procedure TFrmPrincipal.BtnProcurarGDBOkClick(Sender: TObject);
begin
OpenDialog1.Execute;
 Edtonline.Text:=OpenDialog1.FileName +'GDBOK';
end;

procedure TFrmPrincipal.BtnRestoreClick(Sender: TObject);
begin
      FbRestore.UserName :=Edt_User.text;
      FbRestore.Password :=Edt_Senha.text;
      FbRestore.Host := EdtHost.Text;
      FbRestore.Port := EdtPorta.Value;
      FbRestore.Protocol := ipTCPIP;
      FbRestore.Database :=Edt_GDBok.Text;
      FbRestore.BackupFiles.text:=Edt_CaminhoGBK.Text;
      FbRestore.Restore;
      MessageDlg('Restore realizado com sucesso!', mtInformation, [mbOK], 0);
      MmBackup.Lines.Add('Log Gravado em c:\sistemas\LogRestore.txt') ;
      MmBackup.Lines.SaveToFile('c:\sistemas\LogRestore.txt');
end;
          {Aqui Salva o GDBOK}

procedure TFrmPrincipal.BtnSalvarGDBokClick(Sender: TObject);
begin
//OpenDialog1.filter:='GDBOK';
OpenDialog1.Execute;
Edt_GDBok.Text:=OpenDialog1.Filename + 'GDBOK';

end;
      {Aqui gerar o gbk}

procedure TFrmPrincipal.Btn_BackupClick(Sender: TObject);
begin
      FDIBBackup1.UserName :=Edt_User.text;
      FDIBBackup1.Password :=Edt_Senha.text;
      FDIBBackup1.Host := EdtHost.Text;
      FDIBBackup1.Port := EdtPorta.Value;
      FDIBBackup1.Protocol := ipTCPIP;
      FDIBBackup1.Database := EdtCaminhoDados.Text;
      FDIBBackup1.BackupFiles.Text := EdtCaminhoDados.Text + '.gbk';
      FDIBBackup1.Backup;
      MessageDlg('Backup realizado com sucesso!', mtInformation, [mbOK], 0);
      MmBackup.Lines.Add('Log Gravado em c:\sistemas\logbackup.txt') ;
      MmBackup.Lines.SaveToFile('c:\sistemas\logbackup.txt');
end;

      {Aqui Proucurar o GDB}

procedure TFrmPrincipal.Btn_ProcurarGDBClick(Sender: TObject);
begin
//OpenDialog1.Filter:='*.gdb';
OpenDialog1.Execute;
EdtCaminhoDados.text:=OpenDialog1.FileName;
end;
              {COLOCAR O BANCO ONLINE}
procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
FDFBOnline.DriverLink:=FDPhysFBDriverLink1;
FDFBOnline.UserName :=Edt_User.Text;
FDFBOnline.Password :=Edt_Senha.Text;
FDFBOnline.Host :=EdtHost.text;
FDFBOnline.Port :=EdtPorta.Value;
FDFBOnline.Protocol :=ipTCPIP;
FDFBOnline.Database :=Edt_GDBok.Text;
FDFBOnline.Validate;
MessageDlg('Validação do banco realizada com sucesso!', mtInformation, [mbOK], 0);


end;

procedure TFrmPrincipal.Button3Click(Sender: TObject);
var
    QrSqlErros:TFdquery ;
    conexao: TFDConnection;
begin


  if QrSqlErros.Active then
     QrSqlErros.Close;

     QrSqlErros.SQL.Clear; //limpar a instrução sql
     QrSqlErros.SQL.Add('select * FROM RDB$INDICES');
     QrSqlErros.SQL.Add('WHERE RDB$SYSTEM_FLAG IS NOT NULL AND RDB$SYSTEM_FLAG = 0');
     QrSqlErros.SQL.Add('and RDB$INDICES.rdb$index_inactive <> 0');
     QrSqlErros.ExecSQL;

     // Exibir Sql no campo Meno
     MmBackup.Lines.add('exucução de Sql Erros');
     MmBackup.Lines.Add(QrSqlErros.SQL.Text);
     QrSqlErros.Open;
       end;

procedure TFrmPrincipal.Button5Click(Sender: TObject);
begin
FDIBConfig1.DriverLink:=FDPhysFBDriverLink1;
FDIBConfig1.UserName:=Edt_User.text;
FDIBConfig1.Password:=Edt_Senha.Text;
FDIBConfig1.Host:=EdtHost.Text;
FDIBConfig1.Protocol:=ipTCPIP;
FDIBConfig1.Database:=Edt_GDBok.Text;
FDIBConfig1.OnlineDB;

end;

procedure TFrmPrincipal.FbRestoreAfterExecute(Sender: TObject);
begin
MmBackup.Lines.Add('Restauração Concluida com sucesso !')
end;
                {Aqui Proucurar o GBK}
procedure TFrmPrincipal.Btn_ProcurarGbKClick(Sender: TObject);
begin
//OpenDialog1.Filter:='*.gbk';
SaveDialog1.Execute;
Edt_CaminhoGBK.Text:=SaveDialog1.FileName +'.GBK';

end;

procedure TFrmPrincipal.FbRestoreError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
	 MmBackup.Lines.Add('Erro');
	 MmBackup.Lines.Add(AException.Message);
end;

procedure TFrmPrincipal.FbRestoreProgress(ASender: TFDPhysDriverService;
  const AMessage: string);
begin
MmBackup.Lines.add(AMessage);
end;

procedure TFrmPrincipal.FDFBOnlineAfterExecute(Sender: TObject);
begin
MmBackup.Lines.Add('Banco Online!');
end;

procedure TFrmPrincipal.FDFBOnlineBeforeExecute(Sender: TObject);
begin
MmBackup.Clear;
end;

procedure TFrmPrincipal.FDFBOnlineError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
 MmBackup.Lines.Add('Erro ao colocar onlie');
  MmBackup.Lines.Add(AException.Message);
end;

procedure TFrmPrincipal.FDFBOnlineProgress(
  ASender: TFDPhysDriverService; const AMessage: string);
begin
 MmBackup.Lines.Add(AMessage);
end;

procedure TFrmPrincipal.FDFBOnlineValidateAfterExecute(Sender: TObject);
begin
     MmBackup.Lines.Add('Banco Online');
end;

procedure TFrmPrincipal.FDFBOnlineValidateBeforeExecute(Sender: TObject);
begin
  MmBackup.Clear;
end;

procedure TFrmPrincipal.FDIBBackup1AfterExecute(Sender: TObject);
begin
    MmBackup.Lines.Add('Backup conluído com sucesso!');
end;

procedure TFrmPrincipal.FDIBBackup1BeforeExecute(Sender: TObject);
begin
MmBackup.Clear;
end;

procedure TFrmPrincipal.fBRestoreBeforeExecute(Sender: TObject);
begin
MmBackup.Clear;
end;

procedure TFrmPrincipal.FDIBBackup1Error(ASender, AInitiator: TObject;
  var AException: Exception);
begin
 MmBackup.Lines.Add('Erro');
  MmBackup.Lines.Add(AException.Message);
end;

procedure TFrmPrincipal.FDIBBackup1Progress(ASender: TFDPhysDriverService;
  const AMessage: string);
begin
 MmBackup.Lines.Add(AMessage);
end;


procedure TFrmPrincipal.FDIBValidate1AfterExecute(Sender: TObject);
begin
MmBackup.Lines.Add('Validação Concluída com sucesso!');
end;



{Abertura da Janela Help}
procedure TFrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
FrmAjuda:=TFrmAjuda.Create(self);
FrmAjuda.ShowModal;
end;
            {Data/Hora Statusbar}
procedure TFrmPrincipal.Timer1Timer(Sender: TObject);
begin
Statusbar1.Panels [1].Text := ' '+formatdatetime ('dddd","dd" de "mmmm" de "yyyy',now);// para data
statusbar1.Panels [2].Text := ' '+formatdatetime ('hh:mm:ss',now);//para hora


end;

end.
