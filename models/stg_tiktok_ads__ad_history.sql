with base as (

    select *
    from {{ ref('stg_tiktok_ads__ad_history_tmp') }}

), fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_tiktok_ads__ad_history_tmp')),
                staging_columns=get_ad_history_columns()
            )
        }}
    from base

), final as (

    select 
          ad_id
        , updated_at
        , adgroup_id
        , advertiser_id
        , campaign_id
        , ad_name
        , ad_text
        , app_name
        , call_to_action
        , click_tracking_url
        , impression_tracking_url
        , landing_page_url
        , open_url
        , create_time
        , display_name
        , image_ids
        , is_aco
        , is_creative_authorized
        , is_new_structure
        , opt_status
        , playable_url
        , profile_image
        , status
        , video_id
        
        , {{ dbt_utils.surrogate_key(['ad_id','_fivetran_synced'] )}} as version_id
    from fields

)

select *
from final