-- Create the budget object
create table im_budgets (
    budget_id integer constraint budget_id_pk primary key 
    constraint budget_id_fk references cr_revisions(revision_id) on delete cascade,
    budget float,
    budget_hours float,
    budget_hours_explanation text,
    economic_gain float,
    economic_gain_explanation text,
    single_costs float,
    single_costs_explanation text,
    investment_costs float,
    investment_costs_explanation text,
    annual_costs float,
    annual_costs_explanation text,
    approved_p boolean default 'f'
);

select content_type__create_type (
    'im_budget',
    'content_revision',
    'Budget',
    'Budgets',
    'im_budgets',
    'budget_id',
    'content_revision.revision_name'
);

insert into acs_object_type_tables (object_type, table_name, id_column) values ('im_budget','im_budgets','budget_id');

SELECT im_dynfield_attribute_new ('im_budget', 'budget', '#intranet-pmo.Budget#', 'currencies', 'float', 'f', 1, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'budget_hours', '#intranet-pmo.Hours#', 'numeric', 'float', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'budget_hours_explanation', '#intranet-pmo.HoursExplanation#', 'richtext', 'text', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'economic_gain', '#intranet-pmo.EconomicGain#', 'currencies', 'float', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'economic_gain_explanation', '#intranet-pmo.EconomicGainExplanation#', 'richtext', 'text', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'single_costs', '#intranet-pmo.SingleCosts#', 'currencies', 'float', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'single_costs_explanation', '#intranet-pmo.SingleCostsExplanation#', 'richtext', 'text', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'investment_costs', '#intranet-pmo.InvestmentCosts#', 'currencies', 'float', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'investment_costs_explanation', '#intranet-pmo.InvestmentCostsExplanation#', 'richtext', 'text', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'annual_costs', '#intranet-pmo.AnnualCosts#', 'currencies', 'float', 'f', 2, 't');
SELECT im_dynfield_attribute_new ('im_budget', 'annual_costs_explanation', '#intranet-pmo.AnnualCostsExplanation#', 'richtext', 'text', 'f', 2, 't');

select content_type__refresh_view('im_budget');

-- Create the Hour object
create table im_budget_hours (
    hour_id integer constraint hour_id_pk primary key 
    constraint hour_id_fk references cr_revisions(revision_id) on delete cascade,
    hours float,
    department_id integer,
    approved_p boolean default 'f'
);

select content_type__create_type (
    'im_budget_hour',
    'content_revision',
    'Budget Hour',
    'Budget Hours',
    'im_budget_hours',
    'hour_id',
    'content_revision.revision_name'
);

insert into acs_object_type_tables (object_type, table_name, id_column) values ('im_budget_hour','im_budget_hours','hour_id');
SELECT im_dynfield_attribute_new ('im_budget_hour', 'hours', '#intranet-pmo.Hours#', 'numeric', 'float', 'f', 1, 't');     
SELECT im_dynfield_attribute_new ('im_budget_hour', 'department_id', '#intranet-pmo.Department#', 'departments', 'integer', 'f', 2, 't');
select content_type__refresh_view('im_budget_hour');

-- Create the Cost object
create table im_budget_costs (
    cost_id integer constraint cost_id_pk primary key 
    constraint cost_id_fk references cr_revisions(revision_id) on delete cascade,
    amount float,
    type_id integer,
    approved_p boolean default 'f'
);

select content_type__create_type (
    'im_budget_cost',
    'content_revision',
    'Budget Cost',
    'Budget Costs',
    'im_budget_costs',
    'cost_id',
    'content_revision.revision_name'
);

insert into acs_object_type_tables (object_type, table_name, id_column) values ('im_budget_cost','im_budget_costs','cost_id');
SELECT im_dynfield_attribute_new ('im_budget_cost', 'amount', '#intranet-pmo.Amount#', 'currencies', 'float', 'f', 1, 't');     
SELECT im_dynfield_attribute_new ('im_budget_cost', 'type_id', '#intranet-pmo.Type#', 'numeric', 'integer', 'f', 2, 't');
update acs_object_types set type_column='type_id', type_category_type='Intranet Cost Type' where object_type = 'im_budget_cost';
select content_type__refresh_view('im_budget_cost');

-- Create the Benefit object
create table im_budget_benefits (
    benefit_id integer constraint benefit_id_pk primary key 
    constraint benefit_id_fk references cr_revisions(revision_id) on delete cascade,
    amount float,
    type_id integer,
    approved_p boolean default 'f'
);

select content_type__create_type (
    'im_budget_benefit',
    'content_revision',
    'Budget Benefit',
    'Budget Benefits',
    'im_budget_benefits',
    'benefit_id',
    'content_revision.revision_name'
);

insert into acs_object_type_tables (object_type, table_name, id_column) values ('im_budget_benefit','im_budget_benefits','benefit_id');
SELECT im_dynfield_attribute_new ('im_budget_benefit', 'amount', '#intranet-pmo.Amount#', 'currencies', 'float', 'f', 1, 't');     
SELECT im_dynfield_attribute_new ('im_budget_benefit', 'type_id', '#intranet-pmo.Type#', 'numeric', 'integer', 'f', 2, 't');
update acs_object_types set type_column='type_id', type_category_type='Intranet Benefit Type' where object_type = 'im_budget_benefit';
select content_type__refresh_view('im_budget_benefit');




SELECT im_component_plugin__new (null, 'acs_object', now(), null, null, null, 'Project Budget Component', 'intranet-pmo', 'left', '/intranet/projects/view', null, 10, 'im_budget_summary_component -user_id $user_id -project_id $project_id -return_url $return_url');

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

	SELECT plugin_id INTO v_object_id FROM im_component_plugins WHERE plugin_name = ''Project Budget Component'' AND page_url = ''/intranet/projects/view'';

	PERFORM im_grant_permission(v_object_id,v_employees,''read'');
	PERFORM im_grant_permission(v_object_id,v_poadmins,''read'');

	
	RETURN 0;

END;' language 'plpgsql';

SELECT inline_0 ();
DROP FUNCTION inline_0 ();





SELECT im_category_new (3750,'Budget Cost Estimation','Intranet Cost Type');
SELECT im_category_new (3751,'Investment Cost Budget','Intranet Cost Type');
SELECT im_category_new (3752,'One Time Cost Budget ','Intranet Cost Type');
SELECT im_category_new (3753,'Repeating Cost Budget','Intranet Cost Type');

SELECT im_category_hierarchy_new(3751,3750);
SELECT im_category_hierarchy_new(3752,3750);
SELECT im_category_hierarchy_new(3753,3750);

SELECT im_category_new (3760,'Budget Benefit Estimation','Intranet Cost Type');

SELECT im_category_new (9015,'Budget','Intranet Material Type');


---------------------------------------------------------
-- Setup the "Budget" menu entry in "Projects"
--

create or replace function inline_0 ()
returns integer as '
declare
	-- Menu IDs
	v_menu		integer;
	v_parent_menu		integer;
	-- Groups
	v_employees		integer;
	v_accounting		integer;
	v_senman		integer;
	v_customers		integer;
	v_freelancers	integer;
	v_proman		integer;
	v_admins		integer;
BEGIN
	select group_id into v_admins from groups where group_name = ''P/O Admins'';
	select group_id into v_senman from groups where group_name = ''Senior Managers'';
	select group_id into v_proman from groups where group_name = ''Project Managers'';
	select group_id into v_accounting from groups where group_name = ''Accounting'';
	select group_id into v_employees from groups where group_name = ''Employees'';
	select group_id into v_customers from groups where group_name = ''Customers'';
	select group_id into v_freelancers from groups where group_name = ''Freelancers'';

	select menu_id into v_parent_menu from im_menus
	where label=''project'';

	v_menu := im_menu__new (
		null,				-- p_menu_id
		''acs_object'',			-- object_type
		now(),				-- creation_date
		null,				-- creation_user
		null,				-- creation_ip
		null,				-- context_id
		''intranet-pmo'',	-- package_name
		''project_budget'',	-- label
		''Budget'',				-- name
		''/intranet-pmo/budget/budget'', -- url
		50,				-- sort_order
		v_parent_menu,			-- parent_menu_id
		''[expr [im_permission $user_id view_timesheet_tasks] && [im_project_has_type [ns_set get $bind_vars project_id] "Consulting Project"]]'' -- p_visible_tcl
	);

	-- Set permissions of the "Tasks" tab 
	update im_menus
	set visible_tcl = ''[expr [im_permission $user_id view_timesheet_tasks] && [im_project_has_type [ns_set get $bind_vars project_id] "Consulting Project"]]''
	where menu_id = v_menu;

	PERFORM acs_permission__grant_permission(v_menu, v_admins, ''read'');
	PERFORM acs_permission__grant_permission(v_menu, v_senman, ''read'');
	PERFORM acs_permission__grant_permission(v_menu, v_proman, ''read'');
	PERFORM acs_permission__grant_permission(v_menu, v_accounting, ''read'');
	PERFORM acs_permission__grant_permission(v_menu, v_employees, ''read'');
	return 0;
end;' language 'plpgsql';
select inline_0 ();
drop function inline_0 ();


select acs_privilege__create_privilege('approve_budgets','Approve Budgets','Approve Budgets');
select acs_privilege__add_child('admin', 'approve_budgets');


alter table im_projects add column cost_bills_planned numeric(12,2);
alter table im_projects add column cost_expenses_planned numeric(12,2);

