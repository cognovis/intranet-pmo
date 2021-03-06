-- upgrade-4.0.3.0.0-4.0.3.0.1.sql
SELECT acs_log__debug('/packages/intranet-pmo/sql/postgresql/upgrade/upgrade-4.0.3.0.0-4.0.3.0.1.sql','');

SELECT im_component_plugin__new (null, 'acs_object', now(), null, null, null, 'Project Assignment Component', 'intranet-pmo', 'left', '/intranet/projects/view', null, 10, 'im_project_assignment_component -user_id $user_id -project_id $project_id -return_url $return_url');

-- Set component as readable for employees and poadmins
CREATE OR REPLACE FUNCTION inline_0 ()
RETURNS integer AS '
DECLARE

	v_object_id	integer;
	v_employees	integer;
	v_poadmins	integer;

BEGIN
	SELECT group_id INTO v_employees FROM groups where group_name = ''P/O Admins'';

	SELECT group_id INTO v_poadmins FROM groups where group_name = ''Employees'';

	SELECT plugin_id INTO v_object_id FROM im_component_plugins WHERE plugin_name = ''Project Assignment Component'' AND page_url = ''/intranet/projects/view'';

	PERFORM im_grant_permission(v_object_id,v_employees,''read'');
	PERFORM im_grant_permission(v_object_id,v_poadmins,''read'');

	
	RETURN 0;

END;' language 'plpgsql';

SELECT inline_0 ();
DROP FUNCTION inline_0 ();

