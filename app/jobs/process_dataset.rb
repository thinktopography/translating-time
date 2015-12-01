ProcessDataset = Struct.new(:id) do
  def perform
    dataset = Dataset.find(id)
    dataset.process
  end
end