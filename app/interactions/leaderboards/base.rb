module Leaderboards
  class Base < ApplicationInteraction
    include UserStats

    def execute
      users = []
      # Create list of users with stats
      total_betting_amount.each do |user, total|
        users << user_data(user, total)
      end
      users.sort_by! { |user| user[:rank_percentage] }.reverse!
      active_user_ids = users.map { |user| user[:id] }
      group_with_users = []
      # Create list of groups with details
      Group.all.each { |group| group_with_users.push(group_details(group, active_user_ids)) }
      create_lookup_for_user_group_names(group_with_users) # Create hash with key as user id and value as group name
      users = add_group_names_to_users(users)
      groups = calculate_groups_statistics(users, group_with_users)
      groups.sort_by! { |group| group[:rank_percentage] }.reverse!
      { users: users, groups: groups }
    end

    def create_lookup_for_user_group_names(group_with_users)
      @user_groups = {}
      group_with_users.each do |group|
        group[:user_ids].each { |user_id| @user_groups[user_id] = group[:name] }
      end
    end

    def group_details(group, active_user_ids)
      { id: group.id, user_ids: select_and_sort_users_in_group(active_user_ids, group.user_ids), name: group.name }
    end

    def add_group_names_to_users(users)
      users.each { |user| user[:group_name] = @user_groups[user[:id]].to_s }
    end

    def calculate_average_gain_per_user
      average_gain_per_user = {}
      total_betting_amount.keys.each do |user|
        user_id = user.first
        if user_predictions_exist?(user_id)
          net_amount = won_amount_per_user[user_id].to_f - lost_amount_per_user[user_id].to_f
          average_gain_per_user[user_id] = (net_amount / total_predictions_per_user[user_id]).round(2)
        end
      end
      average_gain_per_user
    end

    def user_predictions_exist?(user_id)
      total_predictions_per_user[user_id].present? && !total_predictions_per_user[user_id].zero?
    end

    def user_data(user, total)
      user_id = user.first
      pending_amount = total_pending_amount[user_id].to_f&.round(2)
      resolved_amount = total - pending_amount
      won_amount = points_gained_per_user[user_id].to_f
      {
        total: total,
        pending: pending_amount,
        resolved: resolved_amount,
        won: won_amount,
        # net_points_gain: average_gain_per_user[user_id].to_f,
        # percentage_gain: total.positive? ? (average_gain_per_user[user_id].to_f / total * 100).round(2) : 0.0,
        rank_percentage: calculate_rank_percentage(resolved_amount, won_amount),
        username: user.last,
        id: user_id,
        average_odds: format('%.2f', average_odds_per_user[user_id].to_f).to_f
      }
    end

    def calculate_groups_statistics(active_users, groups)
      groups_data = []
      groups.each do |group|
        groups_data << group_data(group, active_users)
      end
      groups_data
    end

    def select_and_sort_users_in_group(active_user_ids, group_user_ids)
      group_user_ids.select { |user| active_user_ids.include?(user) }
                    .sort_by { |user| active_user_ids.index(user) }
    end

    def group_data(group, active_users)
      group_id = group[:id]
      user_ids = group[:user_ids]
      qualified_user_ids = get_qualified_users(user_ids)
      qualified_users = active_users.select { |user| qualified_user_ids.include?(user[:id]) }
      all_users = active_users.select { |user| user_ids.include?(user[:id]) }
      # Calculate stats for qualified users in group
      qualified_total, qualified_pending, qualified_resolved, qualified_won, qualified_total_odds =
        calculate_stats_for_group(qualified_users)
      # Calculate stats for all users in group
      total, pending, resolved, won, total_odds = calculate_stats_for_group(all_users)
      qualified_users_count = qualified_user_ids.size
      all_users_count = all_users.size
      qualified_average_odds = if qualified_users_count.positive?
                                 (qualified_total_odds / qualified_users_count).round(2)
                               else
                                 0.0
                               end
      average_odds = all_users_count.positive? ? (total_odds / all_users_count).round(2) : 0.0
      {
        total: qualified_total,
        won: qualified_won,
        resolved: qualified_resolved,
        pending: qualified_pending,
        rank_percentage: calculate_rank_percentage(qualified_resolved, qualified_won),
        qualified_users: qualified_user_ids,
        not_qualified_users: user_ids - qualified_user_ids,
        id: group_id,
        average_odds: qualified_average_odds,
        name: group[:name],
        all_user_stats: {
          total: total.round(2),
          won: won.round(2),
          resolved: resolved.round(2),
          pending: pending.round(2),
          rank_percentage: calculate_rank_percentage(resolved, won),
          average_odds: average_odds
        }
      }
    end

    def get_qualified_users(user_ids)
      ids = user_ids.select { |id| qualified_users.include?(id) }
      ids.take(ids.size / 2)
    end

    def calculate_stats_for_group(qualified_users)
      total, pending, resolved, won, total_odds = Array.new(5, 0)
      qualified_users.each do |user|
        total += user[:total]
        pending += user[:pending]
        won += user[:won]
        resolved += user[:resolved]
        total_odds += user[:average_odds]
      end
      [total, pending, resolved, won, total_odds]
    end
  end
end
