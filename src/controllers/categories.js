// Import any needed model functions
import {
    getAllCategories,
    getCategoryDetails,
    getCategoriesByProjectId,
    updateCategoryAssignments
} from '../models/categories.js';
import { getProjectsByCategoryId, getProjectDetails } from '../models/projects.js';

// Define any controller functions
const showCategoriesPage = async (req, res) => {
    const categories = await getAllCategories();
    const title = 'Service Categories';

    res.render('categories', { title, categories });
};

const showCategoryDetailsPage = async (req, res, next) => {
    const categoryId = req.params.id;
    const category = await getCategoryDetails(categoryId);

    if (!category) {
        const err = new Error('Category not found');
        err.status = 404;
        return next(err);
    }

    const projects = await getProjectsByCategoryId(categoryId);
    const title = category.name;

    res.render('category', { title, category, projects });
};

const showAssignCategoriesForm = async (req, res, next) => {
    const projectId = req.params.projectId;

    const projectDetails = await getProjectDetails(projectId);

    if (!projectDetails) {
        const err = new Error('Project not found');
        err.status = 404;
        return next(err);
    }

    const categories = await getAllCategories();
    const assignedCategories = await getCategoriesByProjectId(projectId);

    const title = 'Assign Categories to Project';

    res.render('assign-categories', { title, projectId, projectDetails, categories, assignedCategories });
};

const processAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;

    // A single checked box arrives as a string and none as undefined, so normalize to an array
    const selectedCategoryIds = [].concat(req.body.categoryIds || []);

    await updateCategoryAssignments(projectId, selectedCategoryIds);

    req.flash('success', 'Categories updated successfully.');

    res.redirect(`/project/${projectId}`);
};

// Export any controller functions
export {
    showCategoriesPage,
    showCategoryDetailsPage,
    showAssignCategoriesForm,
    processAssignCategoriesForm
};