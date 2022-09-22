require 'will_paginate/array'

class Admin::TransferRecordsController < Admin::BaseController
  def index
    @records = TransferRecord.referral_reward
    referred_list if params[:referrer_id].present? && query.nil?
    filter_referrals if query.present? && params[:referrer_id].blank?
    @records = @records.order_by_recent
                       .paginate(page: params[:page], per_page: Constants::PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def user_records
    @records = TransferRecord.referral_reward
                             .joins(:payee)
                             .select('users.*, count(transfer_records.id) as referral_count')
                             .group('users.id')
                             .having('count(transfer_records.id) > 0')
                             .order(referral_count: :desc)
                             .paginate(page: params[:page], per_page: Constants::PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private

  def referred_list
    @records = @records.where(payee_id: params[:referrer_id]) if params[:referrer_id].present?
  end
  
  def filter_referrals
    @records = @records.where(payee_id: query[:referrer_id]) if query[:referrer_id].present?
    @records = @records.where(payor_id: query[:referee_id]) if query[:referee_id].present?
    @records = @records.between(query[:start_date].to_date, query[:end_date].to_date) if query[:filter_date].present?
    @records = filter_referral_reward(records: @records) if query[:reward_min_amt].present? || query[:reward_max_amt].present?
    @records = filter_referral_threshold(records: @records) if query[:threshold_min_amt].present? || query[:threshold_max_amt].present?
  end

  def filter_referral_threshold(records:)
    return records.joins(payee: :referrals).where(referrals: { threshold_amount: query[:threshold_min_amt]..query[:threshold_max_amt] }) if query[:threshold_min_amt].present? && query[:threshold_max_amt].present?
    return records.joins(payee: :referrals).where("referrals.threshold_amount >= ?", query[:threshold_min_amt]) if query[:threshold_min_amt].present?
    records.joins(payee: :referrals).where("referrals.threshold_amount <= ?", query[:threshold_max_amt]) if query[:threshold_max_amt].present?
  end

  def filter_referral_reward(records:)
    return records.where(amount: query[:reward_min_amt]..query[:reward_max_amt]) if query[:reward_min_amt].present? && query[:reward_max_amt].present?
    return records.filter_from_amount(query[:reward_min_amt]) if query[:reward_min_amt].present?
    records.filter_to_amount(query[:reward_max_amt]) if query[:reward_max_amt].present?
  end

  def query
    @query ||= params[:query]
  end
end
