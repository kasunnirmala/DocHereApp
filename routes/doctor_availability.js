const express = require('express');
const router = express.Router();
const doctorAvailabilityModel = require('../models/Doctor_Availability')


router.post('/', async (req, res) => {
    const doctorAvailability = new doctorAvailabilityModel({
        id: req.body.id,
        doctor_ID: req.body.doctor_ID,
        nearby: req.body.nearby,
        call_available: req.body.call_available,
        home_visit: req.body.home_visit,
    });

    try {
        const savedDoctorAvailability = await doctorAvailability.save();
        res.json(savedDoctorAvailability);
    } catch (error) {
        res.json({ message: error });
    }
    res.end()
});



router.get('/', async (req, res) => {
    try {
        const doctorsAvailability = await doctorAvailabilityModel.findAll();
        res.json(doctorsAvailability);
    } catch (error) {
        res.json({ message: error });
    }
});


router.get('/:id', async (req, res) => {
    try {
        const doctorAvailability = await doctorAvailabilityModel.findOne({
            where: {
                id: req.params.id
            }
        });
        res.json(doctorAvailability);
    } catch (error) {
        res.json({ message: error });
    }
});

router.patch('/:id', async (req, res) => {
    try {
        const updateDoctorAvailability = await doctorAvailabilityModel.update({
            doctor_ID: req.body.doctor_ID,
            nearby: req.body.nearby,
            call_available: req.body.call_available,
            home_visit: req.body.home_visit
        }, {
            where: { id: req.params.id }
        });
        res.json(updateDoctorAvailability);
    } catch (error) {
        res.json({ message: error });
    }
});


module.exports = router;