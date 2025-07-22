const { PrismaClient, Prisma } = require('@prisma/client');
const prisma = new PrismaClient();

module.exports.create = function create(code, name, credit) {
    return prisma.module.create({
        data: {
            modCode: code,
            modName: name,
            creditUnit: parseInt(credit)  // ✅ Use correct field and ensure it's a number
        }
    }).then(function (module) {
        return module;
    }).catch(function (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === 'P2002') {
                throw new Error(`The module ${code} already exists`);
            }
        }
        throw error;
    });
};

module.exports.updateByCode = function updateByCode(code, credit) {
    return prisma.module.update({
        where: { modCode: code },
        data: { creditUnit: parseInt(credit) }  // ✅ Use correct field and ensure it's a number
    }).catch(function (error) {
        if (error instanceof Prisma.PrismaClientKnownRequestError) {
            if (error.code === 'P2025') {
                throw new Error(`The module ${code} was not found`);
            }
        }
        throw error;
    });
};

module.exports.deleteByCode = async function deleteByCode(code) {
  try {
    // 1. Delete all related preRequisite entries
    await prisma.preRequisite.deleteMany({
      where: {
        OR: [
          { modCode: code },
          { requisite: code }
        ]
      }
    });

    // 2. Delete all related studModPerformance records
    await prisma.studModPerformance.deleteMany({
      where: {
        modRegistered: code
      }
    });

    // 3. Now delete the module itself
    return await prisma.module.delete({
      where: { modCode: code }
    });

  } catch (error) {
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      if (error.code === 'P2025') {
        throw new Error(`The module ${code} was not found`);
      }
    }
    throw error;
  }
};

module.exports.retrieveAll = function retrieveAll() {
    return prisma.module.findMany();
};

module.exports.retrieveByCode = function retrieveByCode(code) {
    return prisma.module.findUnique({
        where: { modCode: code }
    }).then(function (module) {
        if (!module) {
            throw new Error(`The module ${code} was not found`);
        }
        return module;
    }).catch(function (error) {
        throw error;
    });
};
