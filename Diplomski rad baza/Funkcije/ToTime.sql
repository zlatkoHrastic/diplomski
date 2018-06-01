CREATE FUNCTION [dbo].[ToTime]
(
	@seconds int
)
RETURNS time
AS
BEGIN
	declare @minutes varchar(2) = CONVERT(varchar(2),@seconds / 60)
	declare @timeSeconds int =  CONVERT(varchar(2),@seconds % 60)

	RETURN CONVERT( TIME(3), CONCAT('00:',@minutes,':',@timeSeconds))
END
