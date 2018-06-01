CREATE FUNCTION [dbo].[ToSeconds]
(
	@time time
)
RETURNS INT
AS
BEGIN
	RETURN DATEPART(minute,@time)*60+DATEPART(second,@time)
END
