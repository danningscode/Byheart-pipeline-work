with
  ctr as (
    select
      event_time
      , event_id
-- getting clicks from medical and clinical page
      , count(distinct case when click_path = '/pages/medical-professionals' then event_id end) as clicks_from_medical
      , count(distinct case when click_path = '/pages/byheart-clinical-summary' then event_id end) as clicks_from_clinical
    from {{ ref('source_amplitude__events') }}
    where event_type = 'outbound link clicked'
      and
 -- getting all click events that has starter program signup url
      click_url = 'https://forms.gle/ob5YgCEDrYVwfE46A'
    group by event_time, event_id
  )

  , page_views as (
    select
      event_time
      , event_id
-- getting a table of event ids that match the constraint, then count them distinctly
      , count(distinct case when page_viewed_path = '/pages/medical-professionals' then event_id end)
        as medical_page_view
      , count(distinct case when page_viewed_path = '/pages/byheart-clinical-summary' then event_id end) as clinical_page_view
    from {{ ref('source_amplitude__events') }}
    group by event_time, event_id
  )

select
  page_views.event_id
  , page_views.event_time
--getting 0s instead of nulls for sum in looker
  , coalesce(clicks_from_medical, 0) as clicks_from_medical
  , coalesce(clicks_from_clinical, 0) as clicks_from_clinical
  , medical_page_view
  , clinical_page_view
from page_views left join ctr on page_views.event_id = ctr.event_id
--getting rid of random 0s from 2070
where page_views.event_time between '2024-01-01' and '2050-01-01'

