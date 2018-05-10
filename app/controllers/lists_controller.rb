class ListsController < ApplicationController
  def index
    @lists = current_user.lists.order('created_at DESC').page(params[:page]).per(9)
  end

  def edit
    @memos = current_list.memos.order('created_at ASC').page(params[:page])
    current_list.memos.build
    
    @detail_len = current_list.detail.length
  end

  def create
    @list = List.new(user_id: current_user.id, title: 'NewTitle', detail: 'Great Idea')
    
    if @list.save
      flash[:success] = '新規メモを作成しました。'
      redirect_to lists_path
    else
      flash.now[:danger] = '新規メモの作成に失敗しました。'
      redirect_to lists_path
    end    
  end
  
  def update
    
    @list = List.find(params[:id])
    childs = list_params.to_h["memos_attributes"]
    childs_dup = {}
    childs.each do |k,v|
      if v["memotitle"].blank? && v["description"].blank?
        v['_destroy'] = "1"
      end
      childs_dup[k] = v
    end
    
    list_params_dup = list_params.to_h
    list_params_dup["memos_attributes"] = childs_dup

    if @list.update(list_params_dup)
      flash[:success] = 'メモを編集しました。'
      redirect_to lists_path
    else
      @current_list = @list
      flash.now[:danger] = 'メモの作成に失敗しました。'
      render :edit
    end    
  end

  def destroy
    @dlist = current_list
    
    @dlist.destroy
    flash[:success] = 'メモを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def list_params
    params.require(:list).permit(:title, :detail,
      memos_attributes: [:id, :memotitle, :description, :_destroy]
    )
  end
  
end
