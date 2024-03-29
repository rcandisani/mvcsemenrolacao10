#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC001

Cadastro MVC de Tabela de Cadastro de T�cnicos

@author Rog�rio O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC001()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Cadastro de T�cnicos") 
oBrw:SetAlias("ZZA")

oBrw:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Rog�rio O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZZA  := FwFormStruct(1,"ZZA")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC001_M")

// Adiciona ao modelo um componente de formul�rio
oModel:AddFields("ZZAMASTER",/*cOwner*/,oStruZZA)

// Adiciona a descri��o do Modelo de Dados 
oModel:SetDescription("Cadastro de T�cnicos")

// Adiciona a descri��o do Componente do Modelo de Dados
oModel:GetModel("ZZAMASTER" ):SetDescription("Cadastro de T�cnicos")

// Retorna o Modelo de dados 
Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Rog�rio O Candisani 
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel   := FwLoadModel("MVC001")

// Cria a estrutura a ser usada na View 
Local oStruZZA := FwFormStruct(2,"ZZA")

// Interface de visualiza��o constru�da 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados ser� utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formul�rio  
// (antiga Enchoice
oView:AddField("VIEW_ZZA",oStruZZA,"ZZAMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibi��o 
oView:SetOwnerView( 'VIEW_ZZA', 'TELA' )

// Retorna o objeto de View criado
Return(oView)

//----------------------------------------------------------
/*/{Protheus.doc} MenuDef()
MenuDef   

@author Rog�rio O Candisani 
@since 
@version 
/*/
//----------------------------------------------------------
Static Function MenuDef()

Return FWMVCMenu( "MVC001" )