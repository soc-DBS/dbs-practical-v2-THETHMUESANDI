const { query } = require('../database');

module.exports.generateModulesPerformance = function generateModulesPerformance() {
  const sql = 'SELECT * from get_modules_performance() AS result';
  return query(sql)
    .then(function (result) {
      return result.rows;
    })
    .catch(function (error) {
      throw error;
    });
};

module.exports.calculateStudentsGPA = function calculateStudentsGPA() {
  const sql = 'CALL calculate_students_gpa()';
  return query(sql)
    .then(function (result) {
      console.log('Calculating students GPA');
    })
    .catch(function (error) {
      throw error;
    });
};

module.exports.generateAttendance = function generateAttendance() {
  // Replace this with actual SQL to call attendance report function or procedure
  const sql = 'SELECT * FROM get_attendance_report()';  // example, replace accordingly
  return query(sql)
    .then(function (result) {
      return result.rows;
    })
    .catch(function (error) {
      throw error;
    });
};
