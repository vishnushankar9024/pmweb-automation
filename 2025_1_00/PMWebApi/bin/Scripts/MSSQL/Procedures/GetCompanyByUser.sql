CREATE PROCEDURE GetCompanyByUser
@UserId AS BIGINT
AS
BEGIN
SELECT c.Id, c.CompanyName FROM Companies AS c
	INNER JOIN CompanyAddressesContacts AS con ON c.Id = con.CompanyId
	INNER JOIN Users AS u ON con.Id = u.UserContactId
	WHERE u.Id = @UserId
END