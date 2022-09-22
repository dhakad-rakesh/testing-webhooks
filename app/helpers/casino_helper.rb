module CasinoHelper
  def previous_page(meta)
    meta['currentPage'] > 1 ? (meta['currentPage'] - 1) : 1
  end

  def next_page(meta)
    meta['currentPage'] < meta['pageCount'] ? (meta['currentPage'] + 1) : meta['pageCount']
  end

  def paginate_items(meta)
    paginate_first_val(meta)..paginate_last_val(meta)
  end

  def paginate_first_val(meta)
    diff = page_diff(meta)
    if diff > 10
      return meta['currentPage'] == 1 ? (meta['currentPage']+1) : meta['currentPage'] 
    else
      return meta['currentPage'] - 9
    end
  end

  def paginate_last_val(meta)
    diff = page_diff(meta)
    if diff > 10
      return (meta['currentPage'] + 9)
    else
      return meta['currentPage'] 
      # return [meta['currentPage'], (meta['currentPage'] - (diff - 3))].min
    end
  end

  def page_diff(meta)
    meta['pageCount'] - meta['currentPage']
  end

  def paginate_active_first(meta)
    meta['currentPage'] == 1 ? 'active' : ''
  end

  def paginate_active_last(meta)
    meta['currentPage'] == meta['pageCount'] ? 'active' : ''
  end

  def paginate_active(page)
    page == params[:page].to_i ? 'active' : ''
  end

  def paginate_disabled_first(meta)
    meta['currentPage'] == 1 ? 'disabled' : ''
  end

  def paginate_disabled_last(meta)
    meta['currentPage'] == meta['pageCount'] ? 'disabled' : ''
  end

  def redirect_path(item)
    unless item.has_lobby
      init_game_session_casino_path(item.uuid)
    else
      lobby_casino_path(item.uuid)
    end
  end

  def casino_items_provider(items, item_type)
    if item_type.present? && item_type != 'ALL'
      items.where(item_type: item_type.downcase).pluck(:provider).uniq
    else
      items.pluck(:provider).uniq
    end
  end

  def non_live_casino_items(item_types)
    item_types.non_live_casino
              .pluck(:item_type)
              .uniq
              .insert(0,'ALL')
  end

  def live_casino_items(item_types)
    item_types.live_casino
              .pluck(:item_type)
              .uniq
              .insert(0,'ALL')
              .push('OTHER')
  end

  def casino_items(live_casino, item_types)
    if live_casino == "true"
      live_casino_items(item_types)
    else
      non_live_casino_items(item_types)
    end
  end
end
