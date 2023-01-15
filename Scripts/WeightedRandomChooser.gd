class_name WeightedRandomChooser
extends Object

var _acc_weights := []
var _weights := []
var _total_weight := 0.0

func _init() -> void:
	randomize()

func set_values(weights: Array) -> void:
	self._weights = weights
	self._acc_weights.clear()
	self._acc_weights.resize(self._weights.size())
	self._total_weight = 0.0
	
	for i in range(self._weights.size()):
		self._total_weight += self._weights[i]
		self._acc_weights[i] = self._total_weight

func choose() -> int:
	var roll = rand_range(0, self._total_weight)
	
	for i in range(self._weights.size()):
		if self._acc_weights[i] >= roll:
			return i
	
	return -1
