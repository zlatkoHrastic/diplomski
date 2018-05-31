CREATE FUNCTION [dbo].[Sekvenca]
(
	@maksimum int
)
RETURNS @returntable TABLE
(
	broj int
)
AS
BEGIN
	DECLARE @brojac int = 0;
	WHILE @brojac<=@maksimum
	BEGIN
		INSERT @returntable
		SELECT @brojac;
		SET @brojac=@brojac+1
	END	
	RETURN
END
