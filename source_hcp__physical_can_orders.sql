select
    --parse_datetime is converting strings to timestamps
    parse_datetime("%m/%d/%Y %H:%M:%S",timestamp) as created_at,
    by_heart_full_size_product_sampling_order,
    city,
    email_address,
    have_you_recommended_by_heart_before_,
    license_npi_number,
    name,
    practice_name,
    profession,
    state,
    street_address_line_1,
    street_address_line_2,
    why_are_you_interested_in_recommending_by_heart_,
    zip
from {{ source('hcp','hcp_starter_program_request_form_responses_physical_can_orders') }}
