-- Version 6.0.2
Declare @tmpTasks AS TABLE (Indx BIGINT IDENTITY(1,1)
				  ,ID BIGINT
				  ,Code  varchar(40)
				  ,[Name] varchar(120)
				  ,Start datetime
				  ,Finish datetime
				  ,[Type]  varchar(10)
				  ,Duration numeric(17,6)
				  ,ActualStart datetime
				  ,ActualFinish datetime
				  --,ActualDuration numeric(17,6)
				  ,RemainingDuration numeric(17, 6)
				  ,PctComplete numeric(10, 2)
				  ,TotalFloat numeric(17, 6)
				  ,WBSId INT
				  ,WBSCode nvarchar(1000)
				  ,WBSDescription nvarchar(1000)
				  ,IsWBSFilled BIT
				  ,IsSummary BIT
				  ,[Level] BIGINT
				  )
INSERT INTO @tmpTasks
SELECT A.Wbs_id AS ID
	  ,ISNULL(A.wbs_short_name,'')  AS Code
	  ,ISNULL(A.wbs_name,'') AS Name
	  ,'1/1/1900' AS Start
	  ,'1/1/1900'  AS Finish
	  ,'TT_Task' AS task_type
	  ,0 AS Duration
	  ,'1/1/1900' AS ActualStart
	  ,'1/1/1900'  AS ActualFinish
	  ,'0'  AS RemainingDuration
	  ,'0' AS PctComplete
      ,'0' AS TotalFloat
	  ,ISNULL(B.wbs_id,0) AS WBSId
	  ,'' AS WBSCode
      ,ISNULL(B.wbs_name,'') AS WBSDescription
	  ,NULL AS IsWBSFilled
	  ,1 AS IsSummary
	  ,(CASE WHEN ISNULL(B.wbs_id,0) = 0 THEN 1 ELSE NULL END) AS [Level]
FROM projwbs AS A
LEFT OUTER JOIN projwbs AS B  ON A.parent_wbs_id = B.wbs_id AND  B.proj_id = @ProjectId
WHERE A.proj_id = @ProjectId
UNION ALL
SELECT TASK_ID AS [ID]
      ,ISNULL(TASK_CODE,'') AS Code
      ,ISNULL(TASK_NAME,'') AS [Name]
      ,ISNULL(TARGET_START_DATE,'1/1/1900') AS Start
	  ,ISNULL(TARGET_END_DATE,'1/1/1900')  AS Finish
	  ,ISNULL(TASK_TYPE,'')  AS Type
	   ,CASE TASK_TYPE 
			WHEN 'TT_Mile' THEN 0
			WHEN 'TT_FinMile' THEN 0 
			ELSE ISNULL(target_drtn_hr_cnt,0) 
		END AS Duration
      ,ISNULL(ACT_START_DATE,'1/1/1900') AS ActualStart
      ,ISNULL(ACT_END_DATE,'1/1/1900') AS ActualFinish
	  --,0 AS ActualDuration
      ,ISNULL(remain_drtn_hr_cnt,'0')   AS RemainingDuration
      ,ISNULL(phys_complete_pct,'0') AS PctComplete
      ,ISNULL(total_float_hr_cnt,'0')/8 AS TotalFloat
      ,ISNULL(projwbs.wbs_id,0) AS WBSId
      ,'' AS WBSCode
      ,ISNULL(projwbs.wbs_name,'') AS WBSDescription
      ,NULL AS IsWBSFilled
	  ,0 AS IsSummary
	  ,0 AS [Level]
FROM dbo.TASK
LEFT OUTER JOIN projwbs ON projwbs.wbs_id = TASK.wbs_id AND projwbs.proj_Id=@ProjectId
WHERE dbo.TASK.PROJ_ID = @ProjectId



WHILE (SELECT COUNT(*)
		   FROM @tmpTasks 
		   WHERE [Level] IS NULL AND IsSummary = 1
            AND ISNULL(WBSId,0) <> 0 AND WBSId IN (SELECT Id FROM @tmpTasks)) > 0
BEGIN
	UPDATE A
	SET A.[Level] = B.[Level] + 1
	FROM @tmpTasks A INNER JOIN @tmpTasks B
	ON A.[WBSId] = B.[Id]
	WHERE A.[Level] IS NULL AND
		  B.[Level] IS NOT NULL
	AND   A.IsSummary = 1
	AND   B.IsSummary = 1
END

WHILE EXISTS(Select * FROM @tmpTasks WHERE IsWBSFilled IS NULL)
BEGIN

    DECLARE @TaskWBSId AS BIGINT, @currWBSId AS BIGINT, @currWBSCode AS nvarchar(1000)
	SET @currWBSCode = ''
	
	SELECT @TaskWBSId = WBSId  FROM @tmpTasks WHERE IsWBSFilled IS NULL ORDER BY INDX ASC
	
	SET @currWBSId = @TaskWBSId
	WHILE EXISTS(SELECT * FROM projwbs where proj_id = @ProjectId AND wbs_id = @currWBSId)
	BEGIN
		SELECT @currWBSCode =  projwbs.wbs_short_name + '.' + @currWBSCode
			   ,@currWBSId = projwbs.parent_wbs_id
		FROM projwbs 
		WHERE wbs_id = @currWBSId  
	END
	
	IF LEN(@currWBSCode) > 0
	BEGIN
		SET @currWBSCode = LEFT(@currWBSCode,LEN(@currWBSCode) - 1)
	END
	
	UPDATE @tmpTasks
	SET IsWBSFilled = 1
		,WBSCode = @currWBSCode
		,Code =  CASE WHEN IsSummary = 1 AND @currWBSCode <> '' THEN @currWBSCode  + '.' + Code ELSE Code END
	WHERE WBSId = @TaskWBSId 

END

SELECT * FROM @tmpTasks