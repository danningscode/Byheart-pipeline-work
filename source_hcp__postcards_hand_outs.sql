select
    --parse_datetime is converting strings to timestamps
    parse_datetime("%m/%d/%Y %H:%M:%S",date) as created_at,
    hcp_postcards_hand_outs_
from {{ source('hcp','hcp_starter_program_request_form_responses_hcp_postcards_hand_outs_') }}
