import { DAMAC } from './DAMACApi.js';
import { User } from './User.js';
import { CustomFormPhase } from './CustomFormPhase.js';
import { CustomFormChangeOrder } from './ChangeOrder.js';


var CustomForm = { 
    scope: CustomFormPhase,
    ChangeOrder: CustomFormChangeOrder
}

export { CustomForm };