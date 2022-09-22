class Admin::GroupsController < Admin::BaseController
  before_action :set_group, only: %I[show update edit destroy]

  def index
    @groups = Group.all.order(id: :desc).paginate(page: params[:page])
  end

  def new
    @group = Group.new
  end

  def edit; end

  def show; end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.users << User.where(id: params[:group][:users].compact)
      flash[:notice] = t('success_create', name: t('group'))
      redirect_to admin_group_path(@group)
    else
      flash[:error] = t('went_wrong')
      render :new
    end
  end

  def update
    @group.assign_attributes(group_params)
    if @group.save
      flash[:notice] = t('success_update', name: t('group'))
      assign_or_delete_group_users
      return redirect_to edit_admin_group_path(@group) if ['>>', '<<'].include?(params[:commit])
      redirect_to admin_group_path(@group)
    else
      flash[:error] = t('went_wrong')
      redirect_to edit_admin_group_path(@group)
    end
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_path
  end

  private

  def assign_or_delete_group_users
    if params[:commit] == '<<'
      users = User.where(id: params[:group][:group_users])
      @group.users.delete(users)
    else
      @group.users << User.where(id: params[:group][:users].compact)
    end
  end

  def set_group
    @group = Group.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
