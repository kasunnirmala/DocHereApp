const express = require('express');
const router = express.Router();
const doctorLocationModel = require('../models/Doctor_Location')


router.post('/', async (req, res) => {
    const doctorLocation = new doctorLocationModel({
        id: req.body.id,
        doctor_ID: req.body.doctor_ID,
        latitude: req.body.latitude,
        longitude: req.body.longitude
    });

    try {
        const savedDoctorLocation = await doctorLocation.save();
        res.json(savedDoctorLocation);
    } catch (error) {
        res.json({ message: error });
    }
    res.end()
});



router.get('/', async (req, res) => {
    try {
        const doctorsLocation = await doctorLocationModel.findAll();
        res.json(doctorsLocation);
    } catch (error) {
        res.json({ message: error });
    }
});


router.get('/:id', async (req, res) => {
    try {
        const doctorLocation = await doctorLocationModel.findOne({
            where: {
                id: req.params.id
            }
        });
        res.json(doctorLocation);
    } catch (error) {
        res.json({ message: error });
    }
});

router.patch('/:id', async (req, res) => {
    try {
        const updateDoctorLocation = await doctorLocationModel.update({
            doctor_ID: req.body.doctor_ID,
            latitude: req.body.latitude,
            longitude: req.body.longitude
        }, {
            where: { id: req.params.id }
        });
        res.json(updateDoctorLocation);
    } catch (error) {
        res.json({ message: error });
    }
});


module.exports = router;