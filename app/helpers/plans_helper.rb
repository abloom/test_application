module PlansHelper
  def add_placement_path(buy, *args)
    index = @plan.buys.index(buy)
    opts = args.extract_options!
    args << opts.merge(:buy_index => index)
    
    if @plan.new_record?
      add_placement_new_plan_path(*args)
    else
      add_placement_plan_path(@plan, *args)
    end
  end
  
  def add_buy_path(*args)
    if @plan.new_record?
      add_buy_new_plan_path(*args)
    else
      add_buy_plan_path(@plan, *args)
    end
  end
end
