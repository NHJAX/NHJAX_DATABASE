create PROCEDURE [dbo].[procCIO_CheckIn_Preference_Insert]
(
@bas int,
@desg int,
@pref int,
@val varchar(50),
@cby int,
@uby int
)
 AS

INSERT INTO CHECKIN_PREFERENCE
(
	BaseId,
	DesignationId,
	PreferenceId,
	PreferenceValue,
	CreatedBy,
	UpdatedBy
)
VALUES
(
	@bas,
	@desg,
	@pref, 
	@val,
	@cby,
	@uby
);
SELECT SCOPE_IDENTITY();


