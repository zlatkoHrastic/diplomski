CREATE TRIGGER [PripadnostKlubuOgranicenje]
	ON [dbo].[PripadnostKlubu]
	FOR INSERT, UPDATE
	AS
	BEGIN
		SET NOCOUNT ON
		DECLARE @newStart AS dateTime;
		DECLARE @newEnd AS dateTime;
		DECLARE @id AS int;
		DECLARE @ConflictExists AS int = 0;
		DECLARE @idVeslac AS int;

		SELECT @newStart = DatumPocetak  FROM inserted;
		SELECT @newEnd = DatumKraj  FROM inserted;
		SELECT @id= IdPripadnostKlubu  FROM inserted;
		SELECT @idVeslac = IdVeslac from inserted;
		IF EXISTS(
			SELECT * FROM PripadnostKlubu
				WHERE  (@newStart<DatumKraj OR DatumKraj IS NULL) AND (@newEnd>DatumPocetak OR @newEnd is NULL) AND @idVeslac=IdVeslac AND @id!=IdPripadnostKlubu
			)
		BEGIN
		   RAISERROR ('Jedan vesač ne može istovremeno biti član 2 kluba', 16, 1)
		  IF (@@TRANCOUNT>0)
		   ROLLBACK
		END
END
