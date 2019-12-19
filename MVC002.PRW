#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC002

Cadastro MVC de Tabela de SLA

@author Rogério O Candisani
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC002()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Cadastro de SLA") 
oBrw:SetAlias("ZZB")

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
Local oStruZZB  := FwFormStruct(1,"ZZB")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC002_M")

// Adiciona ao modelo um componente de formulário
oModel:AddFields("ZZBMASTER",/*cOwner*/,oStruZZB)

// Adiciona a descrição do Modelo de Dados 
oModel:SetDescription("Cadastro de SLA")

// Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZZBMASTER" ):SetDescription("Cadastro de SLA")

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
Local oModel   := FwLoadModel("MVC002")

// Cria a estrutura a ser usada na View 
Local oStruZZB := FwFormStruct(2,"ZZB")

// Interface de visualização construída 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formulário  
// (antiga Enchoice
oView:AddField("VIEW_ZZB",oStruZZB,"ZZBMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibição 
oView:SetOwnerView( 'VIEW_ZZB', 'TELA' )

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

Return FWMVCMenu( "MVC002" )