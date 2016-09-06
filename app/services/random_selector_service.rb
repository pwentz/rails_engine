module RandomSelectorService
  def random(model)
    model.order("RANDOM()").first
  end
end
