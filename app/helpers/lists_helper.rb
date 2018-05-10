module ListsHelper
  def current_list
    @current_list ||= List.find_by(id: params[:id])
  end
  
end
