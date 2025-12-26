CREATE DATABASE PROJETO_OLIST
GO

USE PROJETO_OLIST
GO

ALTER TABLE tb_clientes ADD CONSTRAINT Pk_Clientes PRIMARY KEY (customer_id)
GO

ALTER TABLE tb_produtos ADD CONSTRAINT PK_Produtos PRIMARY KEY (product_id)
GO

CREATE OR ALTER VIEW vw_Analise_Vendas_Olist AS
SELECT
	p.order_id,
	p.order_status,
	p.order_purchase_timestamp AS Data_Venda,
	p.order_delivered_customer_date AS Data_Entrega,
	pay.payment_type AS Metodo_Pagamento,
	pay.payment_installments AS Parcelas,
	(pay.payment_value /100.0) AS Valor_Total_Pago,
	(i.price / 100.0) AS Valor_Produto,
	(i.freight_value / 100.0) AS Valor_Frete,
	((i.price + i.freight_value) / 100.0) AS Valor_Total_Item,
	c.customer_city AS Cidade_Cliente,
    c.customer_state AS Estado_Cliente,
	REPLACE(prod.product_category_name, '_', ' ') AS Categoria

FROM tb_pedidos P
INNER JOIN tb_itens I ON p.order_id = i.order_id
INNER JOIN tb_clientes c ON p.customer_id = c.customer_id
INNER JOIN tb_produtos prod ON i.product_id = prod.product_id
INNER JOIN tb_pagamentos pay ON p.order_id = pay.order_id
GO

SELECT TOP 10 * FROM vw_Analise_Vendas_Olist
GO


