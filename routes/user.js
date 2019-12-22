const express = require('express');
const router = express.Router();
const userModel = require('../models/User')


router.post('/', async (req, res) => {
    const user = new userModel({
        id: req.body.id,
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        contact_no: req.body.contact_no,
        address: req.body.address
    });

    try {
        const savedUser = await user.save();
        res.json(savedUser);
    } catch (error) {
        res.json({ message: error });
    }
    res.end()
});



router.get('/', async (req, res) => {
    try {
        const users = await userModel.findAll();
        res.json(users);
    } catch (error) {
        res.json({ message: error });
    }
});


router.get('/:id', async (req, res) => {
    try {
        const user = await userModel.findOne({
            where: {
                id: req.params.id
            }
        });
        res.json(user);
    } catch (error) {
        res.json({ message: error });
    }
});

router.patch('/:id', async (req, res) => {
    try {
        const updateUser = await userModel.update({
            first_name: req.body.first_name,
            last_name: req.body.last_name,
            contact_no: req.body.contact_no,
            address: req.body.address
        }, {
            where: { id: req.params.id }
        });
        res.json(updateUser);
    } catch (error) {
        res.json({ message: error });
    }
});


module.exports = router;