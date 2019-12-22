const express = require('express');
const router = express.Router();
const doctorModel = require('../models/Doctor')


router.post('/', async (req, res) => {
    const doctor = new doctorModel({
        id: req.body.id,
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        contact_no: req.body.contact_no,
        address: req.body.address,
        reg_no: req.body.reg_no,
        approved: req.body.approved
    });

    try {
        const savedDoctor = await doctor.save();
        res.json(savedDoctor);
    } catch (error) {
        res.json({ message: error });
    }
    res.end()
});



router.get('/', async (req, res) => {
    try {
        const doctors = await doctorModel.findAll();
        res.json(doctors);
    } catch (error) {
        res.json({ message: error });
    }
});


router.get('/:id', async (req, res) => {
    try {
        const doctor = await doctorModel.findOne({
            where: {
                id: req.params.id
            }
        });
        res.json(docotr);
    } catch (error) {
        res.json({ message: error });
    }
});

router.patch('/:id', async (req, res) => {
    try {
        const updateDoctor = await doctorModel.update({
            first_name: req.body.first_name,
            last_name: req.body.last_name,
            contact_no: req.body.contact_no,
            address: req.body.address,
            reg_no: req.body.reg_no,
            approved: req.body.approved
        }, {
            where: { id: req.params.id }
        });
        res.json(updateDoctor);
    } catch (error) {
        res.json({ message: error });
    }
});


module.exports = router;