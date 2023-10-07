function compute(intArray, target) {
    let best = intArray[0]
    for (let candidate of intArray) {
        if (calcDist(candidate, target) < calcDist(best, target)) {
            best = candidate
        }
    }
    return best
}

function calcDist(input, target) {
    return Math.abs(input - target)
}

let ints = [-7, 5, 2, -1, 9]
console.log(compute(ints, 0))