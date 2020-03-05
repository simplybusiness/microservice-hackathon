function newInfection(infectionRate, { population, infected_population }){
  var nonInfectedPopulation = Math.max((population - infected_population), 0);
  return Math.ceil(nonInfectedPopulation * Math.max(infectionRate, 0));
}

module.exports = newInfection;
