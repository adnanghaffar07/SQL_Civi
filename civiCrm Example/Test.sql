USE civicrmTest_civicrm;

SELECT 
	individual.`display_name` as `Contact Display`,
	organization.`organization_name` as `Employer Organization`,
	COUNT(crmcase.`id`) AS `Case Count`
FROM 
	`civicrm_contact` individual
INNER JOIN 
	`civicrm_contact` organization
 ON 
	organization.`id` = individual.`employer_id`
INNER JOIN 
	`civicrm_case_contact` case_contact
 ON 
	case_contact.`contact_id` = individual.`id`
INNER JOIN 
	`civicrm_case` crmcase
 ON 
	case_contact.`case_id` = crmcase.`id`
WHERE 
	crmcase.`status_id` = 1
GROUP BY individual.`display_name`
ORDER BY individual.`display_name` ASC;
