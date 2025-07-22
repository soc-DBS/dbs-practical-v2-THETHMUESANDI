const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();
const util = require("util");

function getAllStaff() {
  return prisma.staff.findMany({});
}

/** Section A: Basic Queries */

function getHodInfo() {
  return prisma.department.findMany({
    select: {
      deptName: true,
      hodApptDate: true,
    },
  });
}

function getDeptStaffingInfo() {
  return prisma.staff
    .groupBy({
      by: ["deptCode"],
      _count: {
        deptCode: true,
      },
      orderBy: {
        _count: {
          deptCode: "desc",
        },
      },
    })
    .then((result) =>
      result.map((entry) => ({
        deptCode: entry.deptCode,
        noOfStaff: entry._count.deptCode,
      }))
    );
}

/** Section B: Filtering Queries */

function getStaffofSpecificCitizenships() {
  const preferredOrder = ["Hong Kong", "Korea", "Malaysia", "Thailand"];

  return prisma.staff
    .findMany({
      where: {
        citizenship: {
          in: preferredOrder,
        },
      },
      select: {
        citizenship: true,
        staffName: true,
      },
    })
    .then((staff) =>
      staff.sort(
        (a, b) =>
          preferredOrder.indexOf(a.citizenship) -
          preferredOrder.indexOf(b.citizenship)
      )
    );
}

function getStaffByCriteria1() {
  return prisma.staff.findMany({
    where: {
      maritalStatus: "M",
      gender: "M",
      OR: [
        {
          pay: {
            gte: 4000,
            lte: 7000,
          },
        },
        {
          pay: {
            gte: 2000,
            lte: 6000,
          },
        },
      ],
    },
    orderBy: [{ gender: "asc" }, { pay: "asc" }],
    select: {
      gender: true,

      pay: true,
      maritalStatus: true,
      staffName: true,
    },
  });
}

/** Section C: Relation Queries */

function getDepartmentCourses() {
  return prisma.department.findMany({
    orderBy: { deptName: "asc" },
    select: {
      deptName: true,
      course: {
        select: {
          crseName: true,
          crseFee: true,
          labFee: true,
        },
      },
    },
  });
}

function getStaffAndDependents() {
  return prisma.staff.findMany({
    where: {
      staffDependent: {
        some: {},
      },
    },
    select: {
      staffName: true,
      staffDependent: {
        select: {
          dependentName: true,
          relationship: true,
        },
      },
    },
    orderBy: {
      staffName: "asc",
    },
  });
}

function getDepartmentCourseStudentDob() {
  return prisma.department.findMany({
    where: {
      course: {
        some: {
          student: {
            some: {},
          },
        },
      },
    },
    select: {
      deptName: true,
      course: {
        where: {
          student: {
            some: {},
          },
        },
        select: {
          crseName: true,
          student: {
            select: {
              studName: true,
              dob: true,
            },
            orderBy: {
              dob: "asc",
            },
          },
        },
        orderBy: {
          crseName: "asc",
        },
      },
    },
    orderBy: {
      deptName: "asc",
    },
  });
}

/** Entry point */

async function main(argument) {
  let results;

  switch (argument) {
    case "getAllStaff":
      results = await getAllStaff();
      break;
    case "getHodInfo":
      results = await getHodInfo();
      break;
    case "getDeptStaffingInfo":
      results = await getDeptStaffingInfo();
      break;
    case "getStaffofSpecificCitizenships":
      results = await getStaffofSpecificCitizenships();
      break;
    case "getStaffByCriteria1":
      results = await getStaffByCriteria1();
      break;
    case "getDepartmentCourses":
      results = await getDepartmentCourses();
      break;
    case "getStaffAndDependents":
      results = await getStaffAndDependents();
      break;
    case "getDepartmentCourseStudentDob":
      results = await getDepartmentCourseStudentDob();
      break;
    default:
      console.log("Invalid argument");
      return;
  }

  console.log(
    util.inspect(results, { showHidden: false, depth: null, colors: true })
  );
}

main(process.argv[2]);
