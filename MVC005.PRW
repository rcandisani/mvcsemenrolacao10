#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC005

Cadastro MVC de Tela de Chamado por atendente

@author Rogério O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC005()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Cadastro de Técnicos") 
oBrw:SetAlias("ZZA")

oBrw:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Rogério O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oModel		:= Nil
Local oStruZZA  := FwFormStruct(1,"ZZA")
Local oStruZZD  := FwFormStruct(1,"ZZD")

// Cria o objeto do Modelo de Dados
oModel := MPFormModel():New("MVC005_M", /*bPreValidacao*/,/*bPosValidacao*/,/*bCommit*/,/*bCancel*/ )

// Adiciona ao modelo um componente de formulário
oModel:AddFields("ZZAMASTER",/*cOwner*/,oStruZZA, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )

//Relacionamento das tabelas
oModel:AddGrid( "ZZDDETAIL", "ZZAMASTER", oStruZZD,/*bLinePre*/,,/*bPreVal*/ , , /*bLoad*/)
oModel:SetRelation( "ZZDDETAIL", { { "ZZD_FILIAL", "xFilial('ZZA')" }, { "ZZD_TECNIC", "ZZA_COD" } }, ZZD->(IndexKey(1)) )
oModel:SetDescription("Chamado por Atendente") 

// Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZZAMASTER" ):SetDescription("Chamados por Atendente")

oModel:GetModel('ZZDDETAIL'):SetOptional(.T.)
oModel:SetActivate()

// Retorna o Modelo de dados 
Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Rogério O Candisani 
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel   := FwLoadModel("MVC005")

// Cria a estrutura a ser usada na View 
Local oStrZZA := FWFormStruct( 2, "ZZA" , {|cCpo| AllTrim(cCpo)$'ZZA_COD+ZZA_NOME' }  )
Local oStrZZD := FWFormStruct( 2, "ZZD"  )

// Interface de visualização construída 
Local oView 

oStrZZD:SetNoFolder()

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formulário  
// (antiga Enchoice
oView:AddField( 'VIEW_ZZA' , oStrZZA, 'ZZAMASTER' )
oView:AddGrid ( 'VIEW_ZZD' , oStrZZD, 'ZZDDETAIL' )

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox ( 'SUPERIOR' , 15 )
oView:CreateHorizontalBox ( 'INFERIOR' , 85 )

// Relaciona o identificador (ID) da View com o "box" para exibição 
oView:SetOwnerView( 'VIEW_ZZA' , 'SUPERIOR' ) 
oView:SetOwnerView( 'VIEW_ZZD' , 'INFERIOR' )

// Retorna o objeto de View criado
Return(oView)

//----------------------------------------------------------
/*/{Protheus.doc} MenuDef()
MenuDef   

@author Rogério O Candisani 
@since 
@version 
/*/
//----------------------------------------------------------
Static Function MenuDef()

Local aRotina := {}

ADD OPTION aRotina TITLE "Vis. Chamados" ACTION 'U_ChamAten(ZZA->ZZA_COD)' OPERATION 1 ACCESS 0 //Chamados"
 
Return(aRotina)

//----------------------------------------------------------
/*/{Protheus.doc} U_ChamAten
Função para os chamados do atendente   

@author Rogério O Candisani 
@since 
@version 
/*/
//----------------------------------------------------------
User Function ChamAten(cCodAtend)

Local lRetorno := .T. 		// Retorno na rotina.

If !Empty(cCodAtend)
	
	DbSelectArea("ZZD")
	DbSetOrder(1)
	
	If DbSeek(xFilial("ZZD")+cCodAtend)
		FWExecView(Upper("Visualizar"),"VIEWDEF.MVC005",1,/*oDlg*/,/*bCloseOnOk*/,/*bOk*/,/*nPercReducao*/)    // Visualizar
	EndIf
	
Else
	MsgAlert("Selecione um atendente para visualizar","Atenção") 
EndIf

Return( lRetorno )