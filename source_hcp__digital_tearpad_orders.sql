select
    --parse_datetime is converting strings to timestamps
    parse_datetime("%m/%d/%Y %H:%M:%S",timestamp) as created_at,
    city,
    email_address,
    have_you_recommended_by_heart_before_,
    how_did_you_hear_about_by_heart_,
    license_npi_number,
    name,
    office_contact_email_address,
    office_contact_name_may_list_office_manager_if_preferred_,
    practice_name,
    profession,
    starter_program_materials,
    state,
    street_address_line_1,
    street_address_line_2,
    why_are_you_interested_in_recommending_by_heart_,
    zip
from {{ source('hcp','hcp_starter_program_request_form_responses_digital_tearpad_orders') }}
